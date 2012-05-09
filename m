From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Date: Wed, 9 May 2012 18:58:16 -0400
Message-ID: <CAP=VYLobO--uwxv_hiMYBnjD-AU_0fqyQJD6argQygnkHnm5Vg@mail.gmail.com>
References: <20120428205651.GA7426@merkur.ravnborg.org> <20120428205919.GC7442@merkur.ravnborg.org>
 <4FA460AB.6060309@suse.cz> <20120505082916.GA14006@merkur.ravnborg.org>
 <CA+8MBbKd9zAouJy5JvUnLwUHMJ65HsYgCTfBgv42nm32EnMPFA@mail.gmail.com> <20120508165118.GA11750@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59396 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758466Ab2EIW6s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 May 2012 18:58:48 -0400
In-Reply-To: <20120508165118.GA11750@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tony Luck <tony.luck@gmail.com>, Michal Marek <mmarek@suse.cz>, linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>, ralf@linux-mips.org, linux-mips@linux-mips.org

On Tue, May 8, 2012 at 12:51 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Tony.
>
> On Mon, May 07, 2012 at 04:15:44PM -0700, Tony Luck wrote:
>> This patch is now in linux-next (tag next-20120507). But it looks to=
 have
>> broken the ia64 build. I see this error:
>>
>> =A0 CC =A0 =A0 =A0init/version.o
>> =A0 LD =A0 =A0 =A0init/built-in.o
>> =A0 KSYM =A0 =A0.tmp_kallsyms1.o
>> ld: .tmp_kallsyms1.o: linking constant-gp files with non-constant-gp=
 files
>> ld: failed to merge target specific data of file .tmp_kallsyms1.o
>> make: *** [vmlinux] Error 1
>>
>> which looks like we used the wrong compile options when building
>> .tmp_kallsyms1.o
>
> Thanks for testing!
>
> Could you try if this helps.
>
> =A0 =A0 =A0 =A0Sam
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 26c5b65..1f4c27b 100644
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -78,8 +78,8 @@ kallsyms()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kallsymopt=3D--all-symbols
> =A0 =A0 =A0 =A0fi
>
> - =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${NOSTDINC_FLAGS} =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${LINUXINCLUDE} ${KBUILD_CP=
PFLAGS}"
> + =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL=
} =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${NOSTDINC_FLAGS} ${LINUXIN=
CLUDE} ${KBUILD_CPPFLAGS}"

All the linux-next builds for mips are failing, which I tracked down to=
 this.
Applying the above update doesn't help.  What is happening is that MIPS
gets KBUILD_CPPFLAGS double-quoted, and then you get:

+ mips-wrs-linux-gnu-nm -n .tmp_vmlinux1
+ scripts/kallsyms
+ mips-wrs-linux-gnu-gcc -D__ASSEMBLY__ <..snip..>  -D__KERNEL__
'-D"VMLINUX_LOAD_ADDRESS=3D0xffffffff81100000"' '-D"DATAOFFSET=3D0"' -c=
 -o
=2Etmp_kallsyms1.o -x assembler-with-cpp -
<command-line>:0: error: macro names must be identifiers
<command-line>:0: error: macro names must be identifiers
make[1]: *** [vmlinux] Error 1

Note the  '-D"VMLINUX_LOAD_ADDRESS=3D0xffffffff81100000"' '-D"DATAOFFSE=
T=3D0"'
part -- that is what triggers the two above errors.

Paul.

>
> =A0 =A0 =A0 =A0${NM} -n ${1} | \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scripts/kallsyms ${kallsymopt} | \
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
