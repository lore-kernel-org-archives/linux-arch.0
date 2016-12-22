From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 01/14] generic-sections: add section core helpers
Date: Wed, 21 Dec 2016 18:37:57 -0800
Message-ID: <20161222023811.21246-2-mcgrof@kernel.org>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <20161222023811.21246-1-mcgrof@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20161222023811.21246-1-mcgrof@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel
List-Id: linux-arch.vger.kernel.org

Linux makes extensive use of custom ELF header sections,
documentation for these are well scatterred. Unify this
documentation in a central place and provide helpers to
build custom Linux sections.

This also generalizes sections code to enable avoiding
modifying the linker scripts when we want to add new
custom Linux sections. In order to make this generally
useful we need to ensure all architectures can make use of
core section helpers but that they can also override should
this be needed. Instead of relying on section.h this adds
a sections-core.h since this will be targetted to be safe
to be used on asm code, linker scripts and C code.

v5:

o Huge documentation revamp based on a careful review of the ELF
  specifications. Includes documentation now also about usage of
  two dots (..) when prefixing ELF program specific sections.

o Replace macros for sections names in favor of just using
  the section names explicitly in the linker script. This is
  perhaps more work to grep but this is what folks seem to
  currently prefer.

o Fix .text and .rodata documentation to explain memory protection
  strategies which architectures can embrace upon initialization
  (documents CONFIG_DEBUG_RODATA and mark_rodata_ro())

o Skip the 'Linux section ordering' documentation section, we'll instead
  add this on subsequent patch which will expand on it considerably

o Dropped tree on MAINTAINERS -- as per discussions with Arnd, hpa and
  Josh, its easier to just let changes for sections go in through the
  respective tree that needs the changes.

o Fix typos on documentation

o Dropped SECTION_ALL(), __SECTION_CORE(), SECTION_CORE_ALL() macros
  since we are favoring using explicit section names. These are
  useless if we are being explicit.

o Drop LINUX_SECTION_SIZE(), LINUX_SECTION_EMPTY() in favor of having
  section ranges and linker tables define their own, to avoid confusion
  and make code more readable.

o Add __define_initcall() documentation and a small section describing
  our current initcall levels. This should help also clarify what was
  meant about keeping backward compatiblity.

v4:

o Port to shiny new sphinx documentation format

o fix a unicore32 build, turns out this actually fixes unicore32
  defconfig builds which were failing for a long while. unicore32
  does not seem to grok well the type passed on a section declaration,
  this ignores it.

o Use VMLINUX_SYMBOL() in more user symbols (extern C code), not doing
  this was causing final linker issues with blackfin -- this is
  a CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX=y architecture. The other one
  being metatag. metatag is not supported on 0-day so I cannot confirm
  compilation there.

o Added SECTION_CORE() for C code, used later by __LINUX_RANGE()

o Since SECTION_CORE() is defined for linker script and C code, share
  the same helper and just use a __stringify() for the C code as is done
  for the other C helpers.

o move generic sections to asm-generic/section-core.h instead.
  PowerPC compilation blows up if asm/jump_labels.h gets
  section.h included, fixing this is not in any way easy.
  The list of issues are endless. Moving new data to a new
  simple file resolves this.

o since things are now in asm-generic/section-core.h the
  guard changes on asm-generic/sections.h and each architecture
  sections.h are no longer needed

o Give generic sections some maintainer love, that change is
  Acked-by Arnd Bergmann, Josh and hpa.

o A few checkpatch.pl style fixes

o As suggested by James Hogan use generic-y to copy generic
  header files on architectures that do not have a sections.h
  instead of writing a simple file only to include the generic one.

v3:

o add missing sections.h for architectures that did not
  have it

o move generic sections to asm-generic/sections.h

o add generic asm helpers section_type(), section_type_asmtype(),
  push_section_type() -- these helpers enable easy use for
  for later declaring and using of custom linux sections using
  more standard APIs in both C code, asm code (C asm calls, or
  asm files), enabling future standardized section types to
  be more immediately accessible to asm code, not just C code.
  Note for ASM_CMD_SEP we use by default "\n", architectures needed
  to override can do so on their own sections.h prior to inclusion
  of asm-generic/sections.h

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/index.rst                   |   1 +
 Documentation/sections/background.rst     | 105 ++++++++++
 Documentation/sections/conf.py            |   4 +
 Documentation/sections/index.rst          |  17 ++
 Documentation/sections/section-core.rst   | 148 ++++++++++++++
 MAINTAINERS                               |  12 ++
 arch/alpha/include/asm/Kbuild             |   1 +
 arch/arc/include/asm/Kbuild               |   1 +
 arch/arm/include/asm/Kbuild               |   1 +
 arch/arm64/include/asm/Kbuild             |   1 +
 arch/avr32/include/asm/Kbuild             |   1 +
 arch/blackfin/include/asm/Kbuild          |   1 +
 arch/c6x/include/asm/Kbuild               |   1 +
 arch/cris/include/asm/Kbuild              |   1 +
 arch/frv/include/asm/Kbuild               |   1 +
 arch/h8300/include/asm/Kbuild             |   1 +
 arch/hexagon/include/asm/Kbuild           |   1 +
 arch/ia64/include/asm/Kbuild              |   1 +
 arch/m32r/include/asm/Kbuild              |   1 +
 arch/m68k/include/asm/Kbuild              |   1 +
 arch/metag/include/asm/Kbuild             |   1 +
 arch/microblaze/include/asm/Kbuild        |   1 +
 arch/mips/include/asm/Kbuild              |   1 +
 arch/mn10300/include/asm/Kbuild           |   1 +
 arch/nios2/include/asm/Kbuild             |   1 +
 arch/openrisc/include/asm/Kbuild          |   1 +
 arch/parisc/include/asm/Kbuild            |   1 +
 arch/powerpc/include/asm/Kbuild           |   1 +
 arch/s390/include/asm/Kbuild              |   1 +
 arch/score/include/asm/Kbuild             |   1 +
 arch/sh/include/asm/Kbuild                |   1 +
 arch/sparc/include/asm/Kbuild             |   1 +
 arch/tile/include/asm/Kbuild              |   1 +
 arch/um/include/asm/Kbuild                |   1 +
 arch/unicore32/include/asm/section-core.h |  19 ++
 arch/x86/include/asm/Kbuild               |   1 +
 arch/xtensa/include/asm/Kbuild            |   1 +
 include/asm-generic/section-core.h        | 307 ++++++++++++++++++++++++++++++
 include/asm-generic/sections.h            |   2 +
 include/asm-generic/vmlinux.lds.h         |   1 +
 include/linux/init.h                      |  89 +++++++--
 include/linux/sections.h                  |  87 +++++++++
 42 files changed, 809 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/sections/background.rst
 create mode 100644 Documentation/sections/conf.py
 create mode 100644 Documentation/sections/index.rst
 create mode 100644 Documentation/sections/section-core.rst
 create mode 100644 arch/unicore32/include/asm/section-core.h
 create mode 100644 include/asm-generic/section-core.h
 create mode 100644 include/linux/sections.h

diff --git a/Documentation/index.rst b/Documentation/index.rst
index cb5d77699c60..71e0305c036d 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -57,6 +57,7 @@ needed).
    media/index
    gpu/index
    security/index
+   sections/index
    sound/index
    crypto/index
 
diff --git a/Documentation/sections/background.rst b/Documentation/sections/background.rst
new file mode 100644
index 000000000000..0ecf9104aaa2
--- /dev/null
+++ b/Documentation/sections/background.rst
@@ -0,0 +1,105 @@
+======================
+ELF section background
+======================
+
+About
+=====
+
+The purpose of this chapter is to help those not familiar with ELF to brush up
+the latest ELF specifications in order to help understand how Linux uses and
+defines its own ELF sections.
+
+Standardized ELF
+================
+
+The first publication documenting ELF was UNIX System Laboratories' (USL)
+*System V Release 4 Application Binary Interface* (`SRV4 ABI`_) specification.
+Originally ELF was only a small part of the SRV4 ABI, with time however new
+specifications only put focus on ELF, such was the case of the *TIS Portable
+Formats Specification version 1.2* (`TIS 1.2`_). As of TIS 1.2, ELF was
+supplemented with processor specific ELF addendums, available on the *Linux
+Foundation referenced specification page* (`LF ref page`_). The latest ELF
+specification is the *System V Application Binary Interface - DRAFT - 24 April
+2001* (`gabi4`_).
+
+.. _SRV4 ABI: http://www.sco.com/developers/devspecs/gabi41.pdf
+.. _TIS 1.2: https://refspecs.linuxbase.org/elf/elf.pdf
+.. _LF ref page: https://refspecs.linuxbase.org/
+.. _gabi4: https://refspecs.linuxbase.org/elf/gabi4+/contents.html
+
+ELF views on Linux
+==================
+
+There are two views which can be used for inspecting data in an ELF file, a
+Linking view, and an Execution view. A Section Header Table enables one to
+describe an object using the Linking view while a Program Header Table enables
+one to describe an object using the Execution view. The views are not mutually
+exclusive. For intance, vmlinux can be viewed under both views, ``readelf -S
+vmlinux`` for the Linking view, and ``readelf -l vmlinux`` for the Execution
+view.  In Linux only the vmlinux file will have an Execution view, even modules
+lack an Execution view given that vmlinux is the only file that describes how
+the the kernel runs from the start.  All other Linux kernel object files have
+an available Linking view.
+
+Under the Linking view, the Section Header Table describes all available
+sections. The Section Header Table is an array of ELF section header data
+structures. If on a 32-bit system this is ``struct elf32_shd``, if on a 64-bit
+this is ``struct elf64_shdr``. Sections are only visible on object files that
+have a Linking view, since all Linux kernel files have Linking view, all kernel
+objects have ELF sections.
+
+Limitations on ELF sections
+===========================
+
+We provide a summary on the limitations of ELF sections. Refer to the public
+ELF specifications for details. Note that 64-bit limitations may depend
+on processor specific section attributes to be used, refer to your processsor
+specification if unsure.
+
+Its worth ellaborating on the limitations on the name of an ELF section:
+ELF section names are stored as strings as per the ELF specification, and
+as can be expected, these don't have explicit limitations. The implicit
+limitation then depends on the size of an ELF object file and ELF section.
+
+If using really large kernels or objects with large amounts of sections one
+would still need to be sure that ELF loader in charge of loading the Linux
+kernel is properly updated to handle coping with the latest ELF extensions.
+
+   .. flat-table:: Limitations on ELF Sections
+
+      * - Section attribute
+        - 32-bit
+        - 64-bit
+
+      * - ELF section name
+        - Size of an ELF section
+        - Size of an ELF section
+
+      * - Size of an ELF section
+        - 4 GiB
+        - 16 EiB
+
+      * - Max number of sections in an object file
+        - 4 GiEntries (4294967296)
+        - 16 EiEntries (18446744073709551616)
+
+Program specific ELF sections
+=============================
+
+The ELF specification allows for a section type to be specified as
+*Program specific section*, defined as ``SHT_PROGBITS``. This sections type
+enables programs to customize sections for their own use. In assembly this
+specified ``@progbits`` on most architectures, on ARM this is ``%progbits``.
+
+``SHT_PROGBITS`` is used by Linux for defining and using Linux ELF sections.
+
+Special ELF Sections
+====================
+
+The ELF specification defines *Special ELF Sections* on chapter 4 (`gabi4
+ch4`_). These are defined as sections which hold program and control
+information. Of these sections, a few have the section type as
+``SHT_PROGBITS``. This enables Linux to *further customize* use of the section
+beyond what the ELF specification suggests.
+
+.. _gabi4 ch4: https://refspecs.linuxbase.org/elf/gabi4+/ch4.sheader.html#special_sections
diff --git a/Documentation/sections/conf.py b/Documentation/sections/conf.py
new file mode 100644
index 000000000000..faa1c57595e1
--- /dev/null
+++ b/Documentation/sections/conf.py
@@ -0,0 +1,4 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = 'Linux Kernel ELF sections'
+html_search_language = 'en'
diff --git a/Documentation/sections/index.rst b/Documentation/sections/index.rst
new file mode 100644
index 000000000000..f37511ef05e7
--- /dev/null
+++ b/Documentation/sections/index.rst
@@ -0,0 +1,17 @@
+=========================
+Linux Kernel ELF sections
+=========================
+
+This book documents the different ELF sections used on the Linux kernel.
+We start off by providing references to how ELF was standardized, references
+to the standards on ELF sections, review limitations of ELF sections, and
+finally how Linux uses ELF sections in the Linux kernel. Certain important
+Linux ELF sections are documented carefully: we describe the goal of the
+ELF section, and address concurrency considerations when applicable. A few
+common a set of Linux helpers for ELF sections are also documented.
+
+.. toctree::
+   :maxdepth: 4
+
+   background
+   section-core
diff --git a/Documentation/sections/section-core.rst b/Documentation/sections/section-core.rst
new file mode 100644
index 000000000000..ac5815a0d9b3
--- /dev/null
+++ b/Documentation/sections/section-core.rst
@@ -0,0 +1,148 @@
+===================================
+Linux ELF program specific sections
+===================================
+
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: Linux ELF program specific sections
+
+Linux linker script
+===================
+
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: Linux linker script
+
+Memory protection
+-----------------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: Memory protection
+
+mark_rodata_ro
+-----------------------
+.. kernel-doc:: include/linux/init.h
+   :functions: mark_rodata_ro
+
+.rodata
+-------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .rodata
+
+.text
+-----
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .text
+
+.data
+------------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .data
+
+Linux .init\* sections
+======================
+
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: Linux init sections
+
+.init.text
+----------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .init.text
+
+.init.data
+----------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .init.data
+
+.init.rodata
+------------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .init.rodata
+
+Initcall levels
+---------------
+.. kernel-doc:: include/linux/init.h
+   :doc: Initcall levels
+
+.initcall
+-----------------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .initcall
+
+__define_initcall
+-----------------
+.. kernel-doc:: include/linux/init.h
+   :functions: __define_initcall
+
+Linux .exit\* sections
+======================
+
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: Linux exit sections
+
+.exit.text
+----------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .exit.text
+
+.exit.data
+----------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .exit.data
+
+.exitcall.exit
+--------------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .exitcall.exit
+
+Linux .ref\* sections
+=====================
+
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: Linux references to init sections
+
+.ref.text
+---------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .ref.text
+
+.ref.data
+---------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .ref.data
+
+.ref.rodata
+-----------
+.. kernel-doc:: include/asm-generic/section-core.h
+   :doc: .ref.rodata
+
+Generic Linux kernel section helpers
+====================================
+
+Introduction
+-------------
+.. kernel-doc:: include/linux/sections.h
+   :doc: Introduction
+
+LINUX_SECTION_ALIGNMENT
+-----------------------
+.. kernel-doc:: include/linux/sections.h
+   :functions: LINUX_SECTION_ALIGNMENT
+
+LINUX_SECTION_START
+-------------------
+.. kernel-doc:: include/linux/sections.h
+   :functions: LINUX_SECTION_START
+
+LINUX_SECTION_END
+-----------------
+.. kernel-doc:: include/linux/sections.h
+   :functions: LINUX_SECTION_END
+
+DECLARE_LINUX_SECTION
+---------------------
+.. kernel-doc:: include/linux/sections.h
+   :functions: DECLARE_LINUX_SECTION
+
+DECLARE_LINUX_SECTION_RO
+------------------------
+.. kernel-doc:: include/linux/sections.h
+   :functions: DECLARE_LINUX_SECTION_RO
diff --git a/MAINTAINERS b/MAINTAINERS
index d0b2b50705bd..308826f5094b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5422,6 +5422,18 @@ S:	Supported
 F:	drivers/base/power/domain*.c
 F:	include/linux/pm_domain.h
 
+GENERIC SECTIONS
+M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
+M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	"H. Peter Anvin" <hpa@zytor.com>
+L:	linux-arch@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	include/asm-generic/section-core.h
+F:	include/asm-generic/sections.h
+F:	include/asm-generic/vmlinux.lds.h
+F:	Documentation/sections/section-core.rst
+
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index bf8475ce85ee..5422827f1585 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -10,3 +10,4 @@ generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
+generic-y += section-core.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index c332604606dd..7b2cb3dea5fc 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -51,3 +51,4 @@ generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index efb21757d41f..9b69a22a9ae1 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -41,3 +41,4 @@ generic-y += unaligned.h
 
 generated-y += mach-types.h
 generated-y += unistd-nr.h
+generic-y += section-core.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 8365a84c2640..00ace5e826f1 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -45,3 +45,4 @@ generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/avr32/include/asm/Kbuild b/arch/avr32/include/asm/Kbuild
index 241b9b9729d8..f2c3b656a0e7 100644
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@ -22,3 +22,4 @@ generic-y += trace_clock.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index 2fb67b59d188..bf20541bcf21 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -47,3 +47,4 @@ generic-y += unaligned.h
 generic-y += user.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 64465e7e2245..38127ce747be 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -62,3 +62,4 @@ generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index 1778805f6380..385cd88a9d9e 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -45,3 +45,4 @@ generic-y += types.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index 1fa084cf1a43..46d7c599d9b8 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 373cb23301e3..1ec04ec1c82b 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -75,3 +75,4 @@ generic-y += unaligned.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index db8ddabc6bd2..37d7bfae7619 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -60,3 +60,4 @@ generic-y += unaligned.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 502a91d8dbbd..672c6d5da18c 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 860e440611c9..6111e1523750 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -11,3 +11,4 @@ generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 1f2e5d31cb24..1277b45bf4f9 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -34,3 +34,4 @@ generic-y += trace_clock.h
 generic-y += types.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
index 167150c701d1..b1011375cd7a 100644
--- a/arch/metag/include/asm/Kbuild
+++ b/arch/metag/include/asm/Kbuild
@@ -55,3 +55,4 @@ generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index b0ae88c9fed9..c6c2cf6edc98 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -11,3 +11,4 @@ generic-y += preempt.h
 generic-y += syscalls.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 45b0d6568270..a67d3177f3ca 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -20,3 +20,4 @@ generic-y += unaligned.h
 generic-y += user.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
index 1c8dd0f5cd5d..f8145bc85835 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -10,3 +10,4 @@ generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index d63330e88379..c9c7cb82b00f 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -63,3 +63,4 @@ generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 2832f031fb11..86175e701869 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -71,3 +71,4 @@ generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 91f53c07f410..18a9d4c5ead7 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -28,3 +28,4 @@ generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 5c4fbc80dc6c..4322d9746cdb 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += vtime.h
+generic-y += section-core.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 8aea32fe8bd2..63a1c2924b91 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += mm-arch-hooks.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
index a05218ff3fe4..f089a264cd38 100644
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -14,3 +14,4 @@ generic-y += trace_clock.h
 generic-y += xor.h
 generic-y += serial.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 751c3373a92c..7b0356dca562 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -39,3 +39,4 @@ generic-y += termios.h
 generic-y += trace_clock.h
 generic-y += ucontext.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 0569bfac4afb..438f86573dc5 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -21,3 +21,4 @@ generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += types.h
 generic-y += word-at-a-time.h
+generic-y += section-core.h
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index 2d1f5638974c..fb6b831c1fba 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -40,3 +40,4 @@ generic-y += termios.h
 generic-y += trace_clock.h
 generic-y += types.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 052f7f6d0551..580bd5ff828f 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -26,3 +26,4 @@ generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/arch/unicore32/include/asm/section-core.h b/arch/unicore32/include/asm/section-core.h
new file mode 100644
index 000000000000..0b9c68429a1a
--- /dev/null
+++ b/arch/unicore32/include/asm/section-core.h
@@ -0,0 +1,19 @@
+#ifndef __UNICORE_SECTION_CORE_ASM_H__
+#define __UNICORE_SECTION_CORE_ASM_H__
+/*
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+
+/* Unicore32 has known to not work properly with the type set, so ignore it */
+
+#define __set_section_core_type(___section, ___core, ___name,		\
+				___level, ___flags, ___type)		\
+	.section ___section..___core.___name.___level, ___flags
+
+#include <asm-generic/section-core.h>
+
+#endif /* __UNICORE_SECTION_CORE_ASM_H__ */
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 2b892e2313a9..af975f21eeee 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -12,3 +12,4 @@ generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += section-core.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index b7fbaa56b51a..7879c31e66a7 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -32,3 +32,4 @@ generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generic-y += section-core.h
diff --git a/include/asm-generic/section-core.h b/include/asm-generic/section-core.h
new file mode 100644
index 000000000000..bb16befc4251
--- /dev/null
+++ b/include/asm-generic/section-core.h
@@ -0,0 +1,307 @@
+#ifndef _ASM_GENERIC_SECTION_CORE_H_
+#define _ASM_GENERIC_SECTION_CORE_H_
+/*
+ * Linux section core definitions
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+
+/**
+ * DOC: Linux ELF program specific sections
+ *
+ * Linux makes extensive use of ``SHT_PROGBITS`` to both extend use and
+ * definition of *Special ELF Sections* (`gabi4 ch4`_) and to define its own
+ * sections. This chaper is dedicated to documenting Linux program specific
+ * sections and helpers available to make use of these easier to implement and
+ * use.
+ *
+ * .. _gabi4 ch4: https://refspecs.linuxbase.org/elf/gabi4+/ch4.sheader.html#special_sections
+ */
+
+/**
+ * DOC: Linux linker script
+ *
+ * Linux uses a custom linker script to build the vmlinux binary, it uses it to
+ * strategically place and define Linux ELF sections.  Each architecture needs
+ * to implement its own linker script, it is expected to reside in
+ * ``arch/$(ARCH)/kernel/vmlinux.lds.S``.  Architecture Linux linker scripts in
+ * turn include and use definitions from ``include/asm-generic/vmlinux.lds.h``,
+ * as well as some helpers documented in this chapter.
+ *
+ * In assembly it is common practice to use dots (``.``) in labels to avoid
+ * clashes with C symbols. Similarly, a dot (``.``) can be part of a section
+ * name but not a C symbol. Historically then, two dots are used (``..``)
+ * have been used in linker scripts when adding program specific sections
+ * when there are concerns to avoid clashes with compiler generated sections.
+ */
+
+/**
+ * DOC: Memory protection
+ *
+ * Linux allows architectures which support memory protection features to
+ * take advantage of them by letting architectures define and enable
+ * ``CONFIG_DEBUG_RODATA`` and implement a mark_rodata_ro() call.
+ * mark_rodata_ro() can be used for instance to mark specific sections as
+ * read-only or non-executable.
+ *
+ * Linux typically follows a convention to have the .rodata ELF section follow
+ * after the .text ELF section, it does this to help architectures which
+ * support memory protection to mark both .text and .rodata as read-only in
+ * one shot.
+ *
+ * For more details refer to mark_rodata_ro().
+ */
+
+/**
+ * DOC: .rodata
+ *
+ * ELF section used for data which must be protected from write access.
+ */
+
+/**
+ * DOC: .text
+ *
+ * ELF section name used for code (functions) used during regular
+ * kernel run time.
+ */
+
+/**
+ * DOC: .data
+ *
+ * ELF section used for read-write data.
+ */
+
+/**
+ * DOC: Linux init sections
+ *
+ * These sections are used for code and data structures used during boot or
+ * module initialization. On architectures that support it (x86, x86_64), all
+ * this code is freed up by the kernel right before the fist userspace init
+ * process is called when built-in to the kernel, and if modular it is freed
+ * after module initialization. Since the code is freed so early, in theory
+ * there should be no races against freeing this code with other CPUs. Init
+ * section code and data structures should never be exported with
+ * EXPORT_SYMBOL*() as the code will quickly become unavailable to the kernel
+ * after bootup.
+ */
+
+/**
+ * DOC: .init.text
+ *
+ * ELF section for code (functions) used only during boot or driver
+ * initialization.
+ *
+ */
+
+/**
+ * DOC: .init.data
+ *
+ * ELF section used for data structures used only during boot or driver
+ * initialization.
+ */
+
+/**
+ * DOC: .init.rodata
+ *
+ * ELF section used for read-only code (functions) used only during boot
+ * or driver initialization.
+ */
+
+/**
+ * DOC: .initcall
+ *
+ * ELF section used for subsystem init calls. There are init levels
+ * representing different functionality in the kernel. For more details
+ * refer to __define_initcall().
+ */
+
+/**
+ * DOC: Linux exit sections
+ *
+ * These sections are used to declare a functions and data structures which
+ * are only required on exit, the function or data structure will be dropped
+ * if the code declaring this section is not compiled as a module on
+ * architectures that support this (x86, x86_64). There is no special case
+ * handling for this code when built-in to the kernel.
+ */
+
+/**
+ * DOC: .exit.text
+ *
+ * ELF section used to for code (functions) used only during module unload.
+ */
+
+/**
+ * DOC: .exit.data
+ *
+ * ELF section used to for data structures used only during module
+ * unload.
+ */
+
+/**
+ * DOC: .exitcall.exit
+ *
+ * ELF section used for exit routines, order is important and maintained by
+ * link order.
+ */
+
+/**
+ * DOC: Linux references to init sections
+ *
+ * These sections are used to teach modpost to not warn about possible
+ * misuses of init section code from other sections. If you use this
+ * your use case should document why you are certain such use of init
+ * sectioned code is valid. For more details refer to ``include/linux/init.h``
+ * ``__ref``, ``__refdata``, and ``__refconst`` documentation.
+ */
+
+/**
+ * DOC: .ref.text
+ *
+ * ELF section used to annotate code (functions) which has been vetteed as
+ * valid for its reference or use of other code (functions) or data structures
+ * which are part of the init sections.
+ */
+
+/**
+ * DOC: .ref.data
+ *
+ * ELF section used for data structures which have been vetteed for its
+ * reference or use of other code (functions) or data structures part of the
+ * init sections.
+ */
+
+/**
+ * DOC: .ref.rodata
+ *
+ * ELF section used to annotate const code (functions) const data structures
+ * which has been vetteed for its reference or use of other code (functions)
+ * or data structures part of the init sections.
+ */
+
+/* Can be used on foo.S for instance */
+#ifndef __set_section_core_type
+# define __set_section_core_type(___section, ___core, ___name,		\
+				 ___level, ___flags, ___type)		\
+	.section ___section..___core.___name.___level, ___flags, ___type
+#endif
+
+#ifndef __set_section_core
+# define __set_section_core(___section, ___core, ___name, ___level, ___flags) \
+	.section ___section..___core.___name.___level, ___flags
+#endif
+
+#ifndef __push_section_core
+# define __push_section_core(__section, __core, __name, __level, __flags) \
+	.pushsection __section..__core.__name.__level, __flags
+#endif
+
+#ifdef __KERNEL__
+#include <linux/stringify.h>
+#endif
+
+#if defined(__ASSEMBLER__) || defined(__ASSEMBLY__)
+
+# ifndef LINKER_SCRIPT
+
+#  ifndef push_section_core
+#   define push_section_core(__section, __core, __name, __level, __flags) \
+	 __push_section_core(__section, __core, __name,			  \
+			     __level, __stringify(__flags))
+#  endif
+
+#  ifndef set_section_core
+#   define set_section_core(__section, __core, __name,			\
+			    __level, __flags)				\
+	__set_section_core(__section, __core, __name,			\
+			   __level, __stringify(__flags))
+#  endif
+
+#  ifndef set_section_core_type
+#   define set_section_core_type(__section, __core, __name,		\
+				 __level, __flags, __type)		\
+	__set_section_core_type(__section, __core, __name, __level,	\
+				__stringify(__flags), __type)
+#  endif
+
+# endif /* LINKER_SCRIPT */
+#else /* defined(__ASSEMBLER__) || defined(__ASSEMBLY__) */
+
+/*
+ * As per gcc's documentation a common asm separator is a new line followed
+ * by tab [0], it however seems possible to also just use a newline as its
+ * the most commonly empirically observed semantic and folks seem to agree
+ * this even works on S390. In case your architecture disagrees you may
+ * override this and define your own and keep the rest of the macros.
+ *
+ * [0] https://gcc.gnu.org/onlinedocs/gcc/Basic-Asm.html#Basic-Asm
+ */
+# ifndef ASM_CMD_SEP
+#  define ASM_CMD_SEP	"\n"
+# endif
+
+# ifndef set_section_core
+#  define set_section_core(__section, __core, __name, __level, __flags)	\
+	__stringify(__set_section_core_type(__section, __core, __name,	\
+					    __level, __stringify(__flags))) \
+	ASM_CMD_SEP
+# endif
+
+/*
+ * Some architectures (arm, and avr32 are two examples on kprobes) seem
+ * currently explicitly specify the type [0] -- this can be any of the
+ * optional constants on ELF:
+ *
+ * @progbits - section contains data
+ * @nobits - section does not contain data (i.e., section only occupies space)
+ * @note - section contains data which is used by things other than the program
+ * @init_array - section contains an array of pointers to init functions
+ * @fini_array - section contains an array of pointers to finish functions
+ * @preinit_array - section contains an array of pointers to pre-init functions
+ *
+ * ARM requires % instead of @.
+ *
+ * At least as per nasm (x86/x86_64 only), in the absence of qualifiers the
+ * defaults are as follows:
+ *
+ * section .text    progbits  alloc   exec    nowrite  align=16
+ * section .rodata  progbits  alloc   noexec  nowrite  align=4
+ * section .lrodata progbits  alloc   noexec  nowrite  align=4
+ * section .data    progbits  alloc   noexec  write    align=4
+ * section .ldata   progbits  alloc   noexec  write    align=4
+ * section .bss     nobits    alloc   noexec  write    align=4
+ * section .lbss    nobits    alloc   noexec  write    align=4
+ * section .tdata   progbits  alloc   noexec  write    align=4    tls
+ * section .tbss    nobits    alloc   noexec  write    align=4    tls
+ * section .comment progbits  noalloc noexec  nowrite  align=1
+ * section other    progbits  alloc   noexec  nowrite  align=1
+ *
+ * gas should have sensible defaults for architectures...
+ *
+ * [0] http://www.nasm.us/doc/nasmdoc7.html
+ */
+# ifndef set_section_core_type
+#  define set_section_core_type(__section, __core, __name, __level,	\
+				__flags, __type)			\
+	__stringify(__set_section_core_type(__section, __core,		\
+					    __name, __level,		\
+					    __stringify(__flags),	\
+					    __type))			\
+	ASM_CMD_SEP
+# endif
+
+# ifndef push_section_core
+#  define push_section_core(__section, __core, __name,			\
+			    __level, __flags)				\
+	__stringify(__push_section_core(__section, __core,		\
+					__name,	__level,		\
+					__stringify(__flags)))		\
+	ASM_CMD_SEP
+# endif
+
+#endif /* defined(__ASSEMBLER__) || defined(__ASSEMBLY__) */
+#endif /* _ASM_GENERIC_SECTION_CORE_H_ */
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 4df64a1fc09e..b145ae8d9cbe 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENERIC_SECTIONS_H_
 #define _ASM_GENERIC_SECTIONS_H_
 
+#include <asm/section-core.h>
+
 /* References to section boundaries */
 
 #include <linux/compiler.h>
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0968d13b3885..483f60c451f9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -55,6 +55,7 @@
 #endif
 
 #include <linux/export.h>
+#include <asm/section-core.h>
 
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
diff --git a/include/linux/init.h b/include/linux/init.h
index 885c3e6d0f9d..116e3262332a 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -130,6 +130,24 @@ int __init init_rootfs(void);
 extern bool rodata_enabled;
 #endif
 #ifdef CONFIG_DEBUG_RODATA
+/**
+ * mark_rodata_ro - implemement memory protection for ELF sections
+ *
+ * Architectures which support memory protection define a kernel configuration
+ * entry for CONFIG_DEBUG_RODATA, enable it in and implement mark_rodata_ro().
+ * mark_rodata_ro() should strive to adjust the .rodata and .text ELF sections
+ * with read-only memory protection to prevent modifications of these sections
+ * after bootup. It can also try to use memory protection to prevent execution
+ * on the .rodata ELF section.
+ *
+ * In order to help architectures set both .text and .rodata as read-only with
+ * memory protections in one shot Linux has typically followed the convention
+ * to have the .rodata ELF section follow the .text ELF section on the vmlinux
+ * linker script.
+ *
+ * Linux calls mark_rodata_ro() after freeing .init code and prior to calling
+ * the first init userspace process.
+ */
 void mark_rodata_ro(void);
 #endif
 
@@ -140,25 +158,70 @@ extern bool initcall_debug;
 #endif
   
 #ifndef MODULE
+/**
+ * DOC: Initcall levels
+ *
+ * When Linux boots the kernel do_initcalls() iterates over each Linux
+ * initialization level ID and calls all routines embedded on each level ID.
+ * Prior to v2.5.2.3 Linux had only one init level onto which all init
+ * functions folded onto using __initcall(). After v2.5.2.4 Linux split up
+ * initcalls into 7 separate initcall subsection levels, each level describing
+ * different functionality part of the kernel (commit `9d6ba121b7e17085`_
+ * (v2.5.2.3 -> v2.5.2.4)). In order to remain backward compatible __initcall()
+ * calls were left mapped to device_initcall().
+ *
+ * Each init level consists of a dedicated ELF section, init functions are
+ * associated to an init level by linking it into the respective level's
+ * ELF section.
+ *
+ * Lower order init levels run prior to higher order init levels. Ordering
+ * inside each initcall level is determined by respective link order.
+ *
+ * .. _9d6ba121b7e17085: https://git.kernel.org/cgit/linux/kernel/git/history/history.git/commit/?id=9d6ba121b7e17085c95139233686b27a4d4c650e
+ */
 
 #ifndef __ASSEMBLY__
 
-/*
- * initcalls are now grouped by functionality into separate
- * subsections. Ordering inside the subsections is determined
- * by link order. 
- * For backwards compatibility, initcall() puts the call in 
- * the device init subsection.
+/**
+ * __define_initcall - wrapper for definiting init levels
  *
- * The `id' arg to __define_initcall() is needed so that multiple initcalls
- * can point at the same handler without causing duplicate-symbol build errors.
+ * @fn: init routine
+ * @id: init level
  *
- * Initcalls are run by placing pointers in initcall sections that the
- * kernel iterates at runtime. The linker can do dead code / data elimination
- * and remove that completely, so the initcall sections have to be marked
- * as KEEP() in the linker script.
+ * Defines a kernel initialization level. A respective linker script entry
+ * is required to ensure the init level is accounted for and to ensure symbols
+ * exist for iterating over all functions in the init level. A init level
+ * represents a series of functionality in the kernel.
+ *
+ * Ordering within an initialization level is determined by link order, so
+ * for instance if a Makefile had::
+ *
+ *	obj-y += foo.o
+ *	obj-y += bar.o
+ *
+ * And foo.c::
+ *
+ *	subsys_initcall(foo_init);
+ *
+ * And bar.c had::
+ *
+ *	subsys_initcall(bar_init);
+ *
+ * foo_init() would be called prior to bar_init().
+ *
+ * Note that @id in __define_initcall() also enables multiple initcalls
+ * to be created using the same handler for different init levels without
+ * causing duplicate-symbol build errors.
+ *
+ * Initcalls are run by placing start symbols to initcall levels inside ELF
+ * sections, the kernel in turn uses these symbols to iterate over each init
+ * level at runtime with do_initcall_level(). The end of each init level is
+ * marked by the subsequent's symbol's start address until we reach the symbol
+ * ``__initcall_end``. The linker can do dead code / data elimination and each
+ * init level start symbol could be removed completely in this process, to
+ * avoid this each init level start symbols must be marked as 'KEEP()' in the
+ * linker script to avoid any linker optimization heuristic on initcalls.
  */
-
 #define __define_initcall(fn, id) \
 	static initcall_t __initcall_##fn##id __used \
 	__attribute__((__section__(".initcall" #id ".init"))) = fn;
diff --git a/include/linux/sections.h b/include/linux/sections.h
new file mode 100644
index 000000000000..6771c727bcd1
--- /dev/null
+++ b/include/linux/sections.h
@@ -0,0 +1,87 @@
+#ifndef _LINUX_SECTIONS_H
+#define _LINUX_SECTIONS_H
+/*
+ * Linux de-facto sections
+ *
+ * Copyright (C) 2016 Luis R. Rodriguez <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of copyleft-next (version 0.3.1 or later) as published
+ * at http://copyleft-next.org/.
+ */
+
+#include <asm/section-core.h>
+#include <linux/export.h>
+
+#ifndef __ASSEMBLY__
+
+/**
+ * DOC: Introduction
+ *
+ * Linux defines a set of common helpers which can be used to against its use
+ * of standard or custom Linux sections, this section is dedicated to these
+ * helpers.
+ */
+
+/**
+ * LINUX_SECTION_ALIGNMENT - get section alignment
+ *
+ * @name: section name
+ *
+ * Gives you the alignment for the section.
+ */
+#define LINUX_SECTION_ALIGNMENT(name)	__alignof__(*VMLINUX_SYMBOL(name))
+
+/**
+ * LINUX_SECTION_START - get address of start of section
+ *
+ * @name: section name
+ *
+ * This gives you the start address of the section.
+ * This should give you the address of the first entry.
+ *
+ */
+#define LINUX_SECTION_START(name)	VMLINUX_SYMBOL(name)
+
+/**
+ * LINUX_SECTION_END - get address of end of the section
+ *
+ * @name: section name
+ *
+ * This gives you the end address of the section.
+ * This should give you the address of the end of the
+ * section. This will match the start address if the
+ * section is empty.
+ */
+#define LINUX_SECTION_END(name)	VMLINUX_SYMBOL(name##__end)
+
+/**
+ * DECLARE_LINUX_SECTION - Declares a custom Linux section
+ *
+ * @type: type of custom Linux section
+ * @name: custom section name
+ *
+ * Declares a read-write custom Linux section
+ */
+#define DECLARE_LINUX_SECTION(type, name)				\
+	 extern type VMLINUX_SYMBOL(name)[], \
+		     VMLINUX_SYMBOL(name##__end)[]
+
+/**
+ * DECLARE_LINUX_SECTION_RO - Declares a read-only custom Linux section
+ *
+ * @type: type of custom Linux section
+ * @name: custom section name
+ *
+ * Declares a read-only custom Linux section
+ */
+#define DECLARE_LINUX_SECTION_RO(type, name)				\
+	 extern const type VMLINUX_SYMBOL(name)[],			\
+			   VMLINUX_SYMBOL(name##__end)[]
+
+#define __SECTION_CORE(section, core, name, level)			\
+	#section ".." #core "." #name "." #level
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_SECTIONS_H */
-- 
2.10.1
