From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v8 1/5] mm: untag user pointers in mmap/munmap/mremap/brk
Date: Mon, 19 Aug 2019 17:45:38 +0200
Message-ID: <CAAeHK+z6y4_rSH8b8Q=yMmNZYd_bsmMo2XPP0DO-74+=XPPrMg@mail.gmail.com>
References: <20190815154403.16473-1-catalin.marinas@arm.com>
 <20190815154403.16473-2-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190815154403.16473-2-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 15, 2019 at 5:44 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> There isn't a good reason to differentiate between the user address
> space layout modification syscalls and the other memory
> permission/attributes ones (e.g. mprotect, madvise) w.r.t. the tagged
> address ABI. Untag the user addresses on entry to these functions.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Andrey Konovalov <andreyknvl@google.com>

> ---
>  mm/mmap.c   | 5 +++++
>  mm/mremap.c | 6 +-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7e8c3e8ae75f..b766b633b7ae 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -201,6 +201,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>         bool downgraded = false;
>         LIST_HEAD(uf);
>
> +       brk = untagged_addr(brk);
> +
>         if (down_write_killable(&mm->mmap_sem))
>                 return -EINTR;
>
> @@ -1573,6 +1575,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>         struct file *file = NULL;
>         unsigned long retval;
>
> +       addr = untagged_addr(addr);
> +
>         if (!(flags & MAP_ANONYMOUS)) {
>                 audit_mmap_fd(fd, flags);
>                 file = fget(fd);
> @@ -2874,6 +2878,7 @@ EXPORT_SYMBOL(vm_munmap);
>
>  SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
>  {
> +       addr = untagged_addr(addr);
>         profile_munmap(addr);
>         return __vm_munmap(addr, len, true);
>  }
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 64c9a3b8be0a..1fc8a29fbe3f 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -606,12 +606,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>         LIST_HEAD(uf_unmap_early);
>         LIST_HEAD(uf_unmap);
>
> -       /*
> -        * Architectures may interpret the tag passed to mmap as a background
> -        * colour for the corresponding vma. For mremap we don't allow tagged
> -        * new_addr to preserve similar behaviour to mmap.
> -        */
>         addr = untagged_addr(addr);
> +       new_addr = untagged_addr(new_addr);
>
>         if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
>                 return ret;
