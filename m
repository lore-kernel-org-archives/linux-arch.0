Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeJNIpu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 14 Oct 2018 04:45:50 -0400
Date: Sun, 14 Oct 2018 03:06:58 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Message-ID: <20181014010658.GB717@asgard.redhat.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20181014010658.hZ5lRE1G2jwZHbwRsinM49obPCxDaLdrmJwq-qxvMCo@z>

On Fri, Oct 12, 2018 at 03:13:59PM +0530, Firoz Khan wrote:
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> new file mode 100644
> index 0000000..7c9f268

> +86      common  uselib                          sys_ni_syscall

Again, why is this definition left, while others have been removed?

> +348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
> +349     common  statx                           sys_statx
> +350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents

Tab instead of spaces.

> diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh b/arch/parisc/kernel/syscalls/syscallhdr.sh
> new file mode 100644
> index 0000000..607d4ca
> --- /dev/null
> +++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh

/bin/sh -efu

> +# SPDX-License-Identifier: GPL-2.0

"export LANG=C", due to usage of sed/grep/sort.

> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +prefix="$4"
> +offset="$5"
> +
> +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (

grep -E '^[[:xdigit:]Xx]+[[:space:]]+'"${my_abis}" "$in"
sort -n -k1,1

> +    echo "#ifndef ${fileguard}"
> +    echo "#define ${fileguard}"
> +    echo ""

	cat <<-EOF
		#ifndef ${fileguard}
		#define ${fileguard}

	EOF

> +
> +    nxt=0
> +    while read nr abi name entry compat ; do
> +	if [ -z "$offset" ]; then
> +	    echo -e "#define __NR_${prefix}${name}\t$nr"
> +	else
> +	    echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
> +	fi

echo options are not portable; something like

	printf "#define __NR_%s%s\t(%s + %s)" "${prefix}" "${name}" "${offset}" "${nr}"

> +	nxt=$nr
> +	let nxt=nxt+1

"let" is a bash extension, posix-conformant expression would be

	nxt=$((nr + 1))

(I would also check that nr >= nxt, however)

> +    done
> +
> +    echo ""
> +    echo "#ifdef __KERNEL__"
> +    echo -e "#define __NR_syscalls\t$nxt"
> +    echo "#endif"
> +    echo ""
> +    echo "#endif /* ${fileguard} */"

	cat <<-EOF

		#ifdef __KERNEL__
		# define __NR_syscalls\t${nxt}
		#endif

		#endif /* ${fileguard} */
	EOF

> +) > "$out"
> diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
> new file mode 100644
> index 0000000..04abde7
> --- /dev/null
> +++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +in="$1"
> +out="$2"
> +my_abis=`echo "($3)" | tr ',' '|'`
> +offset="$4"
> +
> +emit() {
> +    nxt="$1"
> +    if [ -z "$offset" ]; then
> +	nr="$2"
> +    else
> +	nr="$2"
> +	nr=$((nr+offset))
> +    fi
> +    entry="$3"
> +
> +    while [ $nxt -lt $nr ]; do

It would break nicely if nxt="-n x -o 1" or something like that.

> +	echo "__SYSCALL($nxt, sys_ni_syscall, )"
> +        let nxt=nxt+1
> +    done
> +    echo "__SYSCALL($nxt, $entry, )"
> +}
> +
> +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> +    if [ -z "$offset" ]; then
> +	nxt=0
> +    else
> +	nxt=$offset
> +    fi
> +
> +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"

	my_abi="${my_abis#*|}"

But it looks like that $my_abis includes parentheses and this code
is broken.

> +    while read nr abi name entry compat ; do
> +	if [ $my_abi = "compat" ]; then
> +	    if [ -z "$compat" ]; then
> +		emit $nxt $nr $entry
> +	    else
> +		emit $nxt $nr $compat
> +	    fi
> +	else
> +	    emit $nxt $nr $entry
> +	fi
> +        let nxt=nxt+1
> +    done
> +) > "$out"
> -- 
> 1.9.1
> 
