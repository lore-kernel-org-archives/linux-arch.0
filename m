From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] UAPI: Strip the _UAPI prefix from header guards during
 header installation
Date: Tue, 20 Nov 2012 16:10:40 -0500
Message-ID: <CA+5PVA6_qmbXpN5gsTFuo=nYMA+UoSi76+apW4EyXY1Wg83Myg@mail.gmail.com>
References: <20121113142641.16744.72039.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121113142641.16744.72039.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 13, 2012 at 9:26 AM, David Howells <dhowells@redhat.com> wrote:
> Strip the _UAPI prefix from header guards during header installation so that
> any userspace dependencies aren't affected.  glibc, for example, checks for
> linux/types.h, linux/kernel.h, linux/compiler.h and linux/list.h by their
> guards - though the last two aren't actually exported.
>
>         libtool: compile:  gcc -std=gnu99 -DHAVE_CONFIG_H -I. -Wall -Werror -Wformat -Wformat-security -D_FORTIFY_SOURCE=2 -fno-delete-null-pointer-checks -fstack-protector -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables -c child.c  -fPIC -DPIC -o .libs/child.o
>         In file included from cli.c:20:0:
>         common.h:152:8: error: redefinition of 'struct sysinfo'
>         In file included from /usr/include/linux/kernel.h:4:0,
>                          from /usr/include/linux/sysctl.h:25,
>                          from /usr/include/sys/sysctl.h:43,
>                          from common.h:50,
>                          from cli.c:20:
>         /usr/include/linux/sysinfo.h:7:8: note: originally defined here
>
> Reported-by: Tomasz Torcz <tomek@pipebreaker.pl>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Josh Boyer <jwboyer@redhat.com>

It would be good to get this patch into 3.7 so that the installed
headers aren't broken in subtle ways.

I've changed Linus' email address in the CC field because I'm fairly
sure he doesn't look at the osdl.org one any longer.

josh

> ---
>
>  0 files changed
>
> diff --git a/scripts/headers_install.pl b/scripts/headers_install.pl
> index 239d22d..6c353ae 100644
> --- a/scripts/headers_install.pl
> +++ b/scripts/headers_install.pl
> @@ -42,6 +42,9 @@ foreach my $filename (@files) {
>                 $line =~ s/(^|\s)(inline)\b/$1__$2__/g;
>                 $line =~ s/(^|\s)(asm)\b(\s|[(]|$)/$1__$2__$3/g;
>                 $line =~ s/(^|\s|[(])(volatile)\b(\s|[(]|$)/$1__$2__$3/g;
> +               $line =~ s/#ifndef _UAPI/#ifndef /;
> +               $line =~ s/#define _UAPI/#define /;
> +               $line =~ s!#endif /[*] _UAPI!#endif /* !;
>                 printf {$out} "%s", $line;
>         }
>         close $out;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
