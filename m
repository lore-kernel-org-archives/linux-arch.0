From: Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 0/7]  mm: introduce memfd_secret system call to create "secret" memory areas
Date: Mon, 27 Jul 2020 19:29:28 +0300
Message-ID: <20200727162935.31714-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Christopher Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Elena Reshetova <elena.reshetova-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Idan Yaniv <idan.yaniv-qyM6JfAXOaQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "Kirill A. Shutemov" <kirill-oKw7cIdHH8eLwutG50LtGA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>

Hi,

This is an implementation of "secret" mappings backed by a file descriptor. 

v2 changes:
* Follow Michael's suggestion and name the new system call 'memfd_secret'
* Add kernel-parameters documentation about the boot option
* Fix i386-tinyconfig regression reported by the kbuild bot.
  CONFIG_SECRETMEM now depends on !EMBEDDED to disable it on small systems
  from one side and still make it available unconditionally on
  architectures that support SET_DIRECT_MAP.

The file descriptor backing secret memory mappings is created using a
dedicated memfd_secret system call The desired protection mode for the
memory is configured using flags parameter of the system call. The mmap()
of the file descriptor created with memfd_secret() will create a "secret"
memory mapping. The pages in that mapping will be marked as not present in
the direct map and will have desired protection bits set in the user page
table. For instance, current implementation allows uncached mappings.

Although normally Linux userspace mappings are protected from other users, 
such secret mappings are useful for environments where a hostile tenant is
trying to trick the kernel into giving them access to other tenants
mappings.

Additionally, the secret mappings may be used as a mean to protect guest
memory in a virtual machine host.

For demonstration of secret memory usage we've created a userspace library
[1] that does two things: the first is act as a preloader for openssl to
redirect all the OPENSSL_malloc calls to secret memory meaning any secret
keys get automatically protected this way and the other thing it does is
expose the API to the user who needs it. We anticipate that a lot of the
use cases would be like the openssl one: many toolkits that deal with
secret keys already have special handling for the memory to try to give
them greater protection, so this would simply be pluggable into the
toolkits without any need for user application modification.

I've hesitated whether to continue to use new flags to memfd_create() or to
add a new system call and I've decided to use a new system call after I've
started to look into man pages update. There would have been two completely
independent descriptions and I think it would have been very confusing.

Hiding secret memory mappings behind an anonymous file allows (ab)use of
the page cache for tracking pages allocated for the "secret" mappings as
well as using address_space_operations for e.g. page migration callbacks.

The anonymous file may be also used implicitly, like hugetlb files, to
implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
ABIs in the future.

As the fragmentation of the direct map was one of the major concerns raised
during the previous postings, I've added an amortizing cache of PMD-size
pages to each file descriptor and an ability to reserve large chunks of the
physical memory at boot time and then use this memory as an allocation pool
for the secret memory areas.

v1: https://lore.kernel.org/lkml/20200720092435.17469-1-rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org/
rfc-v2: https://lore.kernel.org/lkml/20200706172051.19465-1-rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org/
rfc-v1: https://lore.kernel.org/lkml/20200130162340.GA14232@rapoport-lnx/

Mike Rapoport (7):
  mm: add definition of PMD_PAGE_ORDER
  mmap: make mlock_future_check() global
  mm: introduce memfd_secret system call to create "secret" memory areas
  arch, mm: wire up memfd_secret system call were relevant
  mm: secretmem: use PMD-size pages to amortize direct map fragmentation
  mm: secretmem: add ability to reserve memory at boot
  mm: secretmem: add ability to reserve memory at boot

 .../admin-guide/kernel-parameters.txt         |   4 +
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/arm64/include/uapi/asm/unistd.h          |   1 +
 arch/riscv/include/asm/unistd.h               |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 fs/dax.c                                      |  10 +-
 include/linux/pgtable.h                       |   3 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/unistd.h             |   7 +-
 include/uapi/linux/magic.h                    |   1 +
 include/uapi/linux/secretmem.h                |   9 +
 kernel/sys_ni.c                               |   2 +
 mm/Kconfig                                    |   4 +
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   3 +
 mm/mmap.c                                     |   5 +-
 mm/secretmem.c                                | 453 ++++++++++++++++++
 18 files changed, 500 insertions(+), 9 deletions(-)
 create mode 100644 include/uapi/linux/secretmem.h
 create mode 100644 mm/secretmem.c

-- 
2.26.2
