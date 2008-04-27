From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all architectures
Date: Sun, 27 Apr 2008 13:56:04 +0200
Message-ID: <20080427115603.GA23493@uranus.ravnborg.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080427113158.GY2252-Aar9JVdAhcRoA3hw4S0G5QR5/fbUUdgG@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Sun, Apr 27, 2008 at 02:31:58PM +0300, Adrian Bunk wrote:
> On Sun, Apr 27, 2008 at 12:51:00PM +0200, Sam Ravnborg wrote:
> > Fix the OPTIMIZE inline functionality such that it can be used
> > by all architectures.
> > To use it the arch maintainers shall add a
> > "select HAVE_OPTIMIZE_INLINING" in their arch specific
> > Kconfig file.
> >...
> 
> My opinion on this is still:
> "OPTIMIZE" means "work around bugs in the kernel".

So then let us name it: GCC_INLINING

Suggested patch below.
I named it _GCC_ because this is a gcc specific feature.

	Sam

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 49590f8..eec5cee 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -68,6 +68,7 @@ config SPARC
 	default y
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_GCC_INLINING
 
 # Identify this as a Sparc32 build
 config SPARC32
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 8acc5cc..98a736c 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -9,6 +9,7 @@ config SPARC
 	bool
 	default y
 	select HAVE_OPROFILE
+	select HAVE_GCC_INLINING
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2fadf79..b6b7795 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -20,6 +20,7 @@ config X86
 	def_bool y
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_GCC_INLINING
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_KVM if ((X86_32 && !X86_VOYAGER && !X86_VISWS && !X86_NUMAQ) || X86_64)
@@ -142,9 +143,6 @@ config AUDIT_ARCH
 config ARCH_SUPPORTS_AOUT
 	def_bool y
 
-config ARCH_SUPPORTS_OPTIMIZED_INLINING
-	def_bool y
-
 # Use the generic interrupt handling code in kernel/irq/:
 config GENERIC_HARDIRQS
 	bool
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 5b1979a..23956ea 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -258,15 +258,3 @@ config CPA_DEBUG
 
 endmenu
 
-config OPTIMIZE_INLINING
-	bool "Allow gcc to uninline functions marked 'inline'"
-	default y
-	help
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  disabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc4 to make the decision can
-	  become the default in the future, until then this option is there to
-	  test gcc for this.
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b2fd754..9e1cdd5 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -31,8 +31,7 @@
 /*
  * Force always-inline if the user requests it so via the .config:
  */
-#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
-    !defined(CONFIG_OPTIMIZE_INLINING) && (__GNUC__ >= 4)
+#if !(defined(CONFIG_GCC_INLINING) && (__GNUC__ >= 4))
 # define inline		inline		__attribute__((always_inline))
 # define __inline__	__inline__	__attribute__((always_inline))
 # define __inline	__inline	__attribute__((always_inline))
diff --git a/init/Kconfig b/init/Kconfig
index ba3a389..8d6eb70 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -508,6 +508,25 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+# archs shall "select HAVE_GCC_INLINING" to be offered the
+# possibility to enable GCC_INLINING
+config HAVE_GCC_INLINING
+	def_bool n
+
+config GCC_INLINING
+	bool "Enable gcc 4.0 inline algorithm for functions marked 'inline'"
+	depends on HAVE_GCC_INLINING
+	help
+	  This option determines if the kernel forces gcc to inline the
+	  functions developers have marked 'inline'. Doing so takes away
+	  freedom from gcc to do what it thinks is best, which is desirable
+	  for the gcc 3.x series of compilers.
+	  The gcc 4.x series have a rewritten inlining algorithm and
+	  enabling this option will generate a smaller kernel there.
+	  Hopefully this algorithm is so good that allowing gcc4 to
+	  make the decision can become the default in the future,
+	  until then this option is there to test gcc for this.
+
 config SYSCTL
 	bool
 
