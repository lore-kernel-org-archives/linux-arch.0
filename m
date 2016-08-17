From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/6] kbuild: add arch specific post-link pass
Date: Wed, 17 Aug 2016 14:43:22 +1000
Message-ID: <20160817144322.4067391f@roar.ozlabs.ibm.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
	<1470910580-18458-4-git-send-email-npiggin@gmail.com>
	<57B2DBA1.6090304@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <57B2DBA1.6090304@suse.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 16 Aug 2016 11:23:45 +0200
Michal Marek <mmarek@suse.com> wrote:

> Dne 11.8.2016 v 12:16 Nicholas Piggin napsal(a):
> >  $(modules): %.ko :%.o %.mod.o FORCE
> >  	$(call if_changed,ld_ko_o)
> > +ifdef CONFIG_BUILD_ARCH_POSTLINK
> > +	$(Q)$(MAKE) -f $(srctree)/arch/$(SRCARCH)/Makefile.postlink $@
> > +endif  
> 
> Why not simply branch off the existence of arch/*/Makefile.postlink and
> drop the kconfig option?

I just did not think of it. That does seem nicer, thanks. What do
you think of this?


Allow architectures to create arch/xxx/Makefile.postlink with targets
for vmlinux, modules.ko, and clean, which will be invoked after final
linking of vmlinux and modules.

powerpc will use this to check vmlinux linker relocations for sanity,
and may use it to fix up alternate instruction patch branch addresses.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
Since v1,
- Switched to a more flexible arch makefile invocation.
- Provide a powerpc patch to use it to help existing build issue
  (rather than only justification being out-of-tree patch).

Since v2
- Depend on existence of Makefile.modpost, rather than config option.
- Move post-vmlinux invocation into Makefile rather than link-vmlinux.sh
- Add a clean target

---
 Documentation/kbuild/makefiles.txt | 16 ++++++++++++++++
 Makefile                           |  7 +++++++
 scripts/Makefile.modpost           |  6 ++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 385a5ef..ce93dc7 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -41,6 +41,7 @@ This document describes the Linux kernel Makefiles.
 	   --- 6.8 Custom kbuild commands
 	   --- 6.9 Preprocessing linker scripts
 	   --- 6.10 Generic header files
+	   --- 6.11 Post-link pass
 
 	=== 7 Kbuild syntax for exported headers
 		--- 7.1 header-y
@@ -1237,6 +1238,21 @@ When kbuild executes, the following steps are followed (roughly):
 	to list the file in the Kbuild file.
 	See "7.4 generic-y" for further info on syntax etc.
 
+--- 6.11 Post-link pass
+
+	If the file arch/xxx/Makefile.postlink exists, this makefile
+	will be invoked for post-link objects (vmlinux and modules.ko)
+	for architectures to run post-link passes on. Must also handle
+	the clean target.
+
+	This pass runs after kallsyms generation. If the architecture
+	needs to modify symbol locations, rather than manipulate the
+	kallsyms, it may be easier to add another postlink target for
+        .tmp_vmlinux? targets to be called from link-vmlinux.sh.
+
+	For example, powerpc uses this to check relocation sanity of
+	the linked vmlinux file.
+
 === 7 Kbuild syntax for exported headers
 
 The kernel includes a set of headers that is exported to userspace.
diff --git a/Makefile b/Makefile
index 1d26fdb..20d3bfd 100644
--- a/Makefile
+++ b/Makefile
@@ -954,8 +954,14 @@ include/generated/autoksyms.h: FORCE
       cmd_link-vmlinux = $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
 quiet_cmd_link-vmlinux = LINK    $@
 
+# Optional arch pass after final link
+ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
+      cmd_postlink-vmlinux = \
+          $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+
 vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
 	+$(call if_changed,link-vmlinux)
+	+$(call if_changed,postlink-vmlinux)
 
 # Build samples along the rest of the kernel
 ifdef CONFIG_SAMPLES
@@ -1279,6 +1285,7 @@ $(clean-dirs):
 
 vmlinuxclean:
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
+	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
 
 clean: archclean vmlinuxclean
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 1366a94..a3e862e 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -121,8 +121,14 @@ quiet_cmd_ld_ko_o = LD [M]  $@
                              $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) \
                              -o $@ $(filter-out FORCE,$^)
 
+# Optional arch pass after final link
+ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
+      cmd_postlink-ko = \
+          $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
+
 $(modules): %.ko :%.o %.mod.o FORCE
 	$(call if_changed,ld_ko_o)
+	+$(call if_changed,postlink-ko)
 
 targets += $(modules)
 
-- 
2.8.1

