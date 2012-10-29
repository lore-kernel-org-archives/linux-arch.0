From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 01/11] m68k: switch to using the asm-generic auxvec.h
Date: Mon, 29 Oct 2012 10:42:48 +0000
Message-ID: <18903.1351507368@warthog.procyon.org.uk>
References: <1351489774-14263-2-git-send-email-gerg@snapgear.com> <1351489774-14263-1-git-send-email-gerg@snapgear.com>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1351489774-14263-2-git-send-email-gerg@snapgear.com>
Sender: linux-m68k-owner@vger.kernel.org
To: gerg@snapgear.com
Cc: dhowells@redhat.com, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>
List-Id: linux-arch.vger.kernel.org

<gerg@snapgear.com> wrote:

> diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
> index 972bce1..588c3cc 100644
> --- a/arch/m68k/include/uapi/asm/Kbuild
> +++ b/arch/m68k/include/uapi/asm/Kbuild
> @@ -2,7 +2,6 @@
>  include include/uapi/asm-generic/Kbuild.asm
>  
>  header-y += a.out.h
> -header-y += auxvec.h
>  header-y += byteorder.h
>  header-y += cachectl.h
>  header-y += fcntl.h

Rather than removing header-y from the uapi Kbuild, you probably want to add a
generic-y there.

David
