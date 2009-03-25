From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] MIPS: o32: Get rid of useless wrapper for llseek
Date: Wed, 25 Mar 2009 18:29:05 +0100
Message-ID: <20090325182905.5fbca9df@osiris.boeblingen.de.ibm.com>
References: <20090325001555.GA1357@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762107AbZCYR3X@vger.kernel.org>
In-Reply-To: <20090325001555.GA1357@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dann frazier <dannf@dannf.org>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

On Wed, 25 Mar 2009 01:15:55 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  arch/mips/kernel/linux32.c     |    7 -------
>  arch/mips/kernel/scall64-o32.S |    2 +-
>  2 files changed, 1 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
> index 49aac6e..ab2da41 100644
> --- a/arch/mips/kernel/linux32.c
> +++ b/arch/mips/kernel/linux32.c
> @@ -133,13 +133,6 @@ SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
>  	return sys_ftruncate(fd, merge_64(a2, a3));
>  }
> 
> -SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
> -	unsigned long, offset_low, loff_t __user *, result,
> -	unsigned long, origin)
> -{
> -	return sys_llseek(fd, offset_high, offset_low, result, origin);
> -}
> -

Ah.. this hunk seems to be the origin of the bug. git commit
dbda6ac0897603f6c6dfadbbc37f9882177ec7ac "MIPS: CVE-2009-0029: Enable
syscall wrappers." contains this:

-asmlinkage int sys32_llseek(unsigned int fd, unsigned int offset_high,
-			    unsigned int offset_low, loff_t __user * result,
-			    unsigned int origin)
+SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
+	unsigned long, offset_low, loff_t __user *, result,
+	unsigned long, origin)

Here you converted offset_low from unsigned int to unsigned long. Hence
you lost the clearing of the upper 32 bits. That would explain the bug.
Any chance the process where the bug was seen was a compat process?

Patch below would probably fix it.

Btw. there are a lot of int->long conversions in the git commit
mentioned above. AFAICS all(?) of the conversions are wrong.

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 1a86f84..5abcc7f 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -134,9 +134,9 @@ SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
 	return sys_ftruncate(fd, merge_64(a2, a3));
 }
 
-SYSCALL_DEFINE5(32_llseek, unsigned long, fd, unsigned long, offset_high,
-	unsigned long, offset_low, loff_t __user *, result,
-	unsigned long, origin)
+SYSCALL_DEFINE5(32_llseek, unsigned int, fd, unsigned int, offset_high,
+		unsigned int, offset_low, loff_t __user *, result,
+		unsigned int, origin)
 {
 	return sys_llseek(fd, offset_high, offset_low, result, origin);
 }
