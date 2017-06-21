From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Wed, 21 Jun 2017 10:17:11 +0900
Message-ID: <CAK7LNAS6zucv54-XwqfTbm=y20eFVQYLwgsVCdtS7mYknsYK+Q@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-2-npiggin@gmail.com>
 <CAK7LNASxuE-6eMk+Y-vyrMfibtYoD2JkjNS2z8QF85x9NdiiaA@mail.gmail.com>
 <20170619165100.3ce26d00@roar.ozlabs.ibm.com> <CAK7LNARuuQzGkYBdzoy3bVpBuNPZEMGerHSEdmrH+PqK0Gbyzg@mail.gmail.com>
 <20170619182714.2cb60e17@roar.ozlabs.ibm.com> <CAK7LNATznx=5A1KnhkFHpjencsJj7AGUsHtDUu6M-Qkw=jvpPQ@mail.gmail.com>
 <20170620015205.329519b2@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170620015205.329519b2@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>
List-Id: linux-arch.vger.kernel.org

Hi Nicholas,

2017-06-20 0:52 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
>>
>> masahiro@pug:~$ xtensa-linux-ld -v
>> GNU ld (GNU Binutils) 2.24
>
> Ah, thank you. It must have been that the 0day build (cc'ed) did
> not return any error to be from the ld internal error.
>
> This has led me to the true cause of the error which is the way
> external archives are handled. After implementing the fix, I think
> the lib.a size regression for thin archives should be solved as
> well.


Thanks for figuring this out!


> This patch should be added between patches 2 and 3 of this series.
>

Done.


I applied all 6 patches to linux-kbuild/thin-ar.

I fixed up some:

[1] fix a typo  "tihs"  -> "this"
[2] reword the document as "The build system has, as of 4.13, switched
to using..."
[3] Add "P" to link_vmlinux.sh as well


Could you double-check if I did them correctly?




> --- a/Makefile
> +++ b/Makefile
> @@ -952,19 +952,20 @@ core-y            := $(patsubst %/, %/built-in.o, $(core-y))
>  drivers-y      := $(patsubst %/, %/built-in.o, $(drivers-y))
>  net-y          := $(patsubst %/, %/built-in.o, $(net-y))
>  libs-y1                := $(patsubst %/, %/lib.a, $(libs-y))
> -libs-y2                := $(patsubst %/, %/built-in.o, $(libs-y))
> +libs-y2                := $(filter-out %.a, $(patsubst %/, %/built-in.o, $(libs-y)))
>  libs-y         := $(libs-y1) $(libs-y2)


After I applied this patch, I noticed one more thing.

With this patch, I think "libs-y" will be unnecessary.

If you ack me to fix-up locally, I will remove:
   libs-y         := $(libs-y1) $(libs-y2)




> @@ -50,7 +57,7 @@ archive_builtin()
>         if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
>                 info AR built-in.o
>                 rm -f built-in.o;
> -               ${AR} rcsT${KBUILD_ARFLAGS} built-in.o                  \
> +               ${AR} rcsTP${KBUILD_ARFLAGS} built-in.o                 \
>                                         ${KBUILD_VMLINUX_INIT}          \
>                                         ${KBUILD_VMLINUX_MAIN}
>         fi

I moved this hunk to  2/6 "thin archives use P option to ar".


-- 
Best Regards
Masahiro Yamada
