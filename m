From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v3 3/5] m68k: add system call table generation support
Date: Tue, 2 Oct 2018 08:52:03 +1000 (AEST)
Message-ID: <alpine.LNX.2.21.1810020843320.10@nippy.intranet>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org> <1538397477-4003-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538397477-4003-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Mon, 1 Oct 2018, Firoz Khan wrote:

> --- /dev/null
> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh

That's not accurate. These are bash scripts, not Bourne shell.

If you run 'checkbashisms', you'll see that a few small changes are needed 
in order to gain standards compliance and portability.

Some untested suggestions:

diff --git a/arch/m68k/kernel/syscalls/syscallhdr.sh b/arch/m68k/kernel/syscalls/syscallhdr.sh
index e0e3108cfc7f..9811f82848e6 100644
--- a/arch/m68k/kernel/syscalls/syscallhdr.sh
+++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
@@ -18,17 +18,17 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
     nxt=0
     while read nr abi name entry ; do
 	if [ -z "$offset" ]; then
-	    echo -e "#define __NR_${prefix}${name}\t$nr"
+	    echo "#define __NR_${prefix}${name}	$nr"
 	else
-	    echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
+	    echo "#define __NR_${prefix}${name}	($offset + $nr)"
 	fi
 	nxt=$nr
-	let nxt=nxt+1
+	nxt=$((nxt+1))
     done
 
     echo ""
     echo "#ifdef __KERNEL__"
-    echo -e "#define __NR_syscalls\t$nxt"
+    echo "#define __NR_syscalls	$nxt"
     echo "#endif"
     echo ""
     echo "#endif /* ${fileguard} */"
diff --git a/arch/m68k/kernel/syscalls/syscalltbl.sh b/arch/m68k/kernel/syscalls/syscalltbl.sh
index d2635dea4e96..89ab047097ce 100644
--- a/arch/m68k/kernel/syscalls/syscalltbl.sh
+++ b/arch/m68k/kernel/syscalls/syscalltbl.sh
@@ -13,7 +13,7 @@ emit() {
 
     while [ $nxt -lt $nr ]; do
 	echo "__SYSCALL($nxt, sys_ni_syscall, )"
-	let nxt=nxt+1
+	nxt=$((nxt+1))
     done
 
     echo "__SYSCALL($nr, $entry, )"
@@ -29,6 +29,6 @@ grep '^[0-9]' "$in" | sort -n | (
     while read nr abi name entry ; do
 	emit $nxt $nr $entry
 	nxt=$nr
-        let nxt=nxt+1
+        nxt=$((nxt+1))
     done
 ) > "$out"

-- 
