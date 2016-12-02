From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [RFC, PATCH, v3.9] default exported asm symbols to zero
Date: Fri, 2 Dec 2016 16:35:35 +0100
Message-ID: <20161202153535.GB16491@angband.pl>
References: <20161129131922.GA31466@angband.pl>
 <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
 <14455987.OWjnZpEEup@wuerfel>
 <8452191.39CeLIHTBT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <8452191.39CeLIHTBT@wuerfel>
Resent-Message-ID: <zCFdXRyOp1H.A.faD.dTZQYB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20161202153535.GB16491@angband.pl
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 02, 2016 at 01:40:27PM +0100, Arnd Bergmann wrote:
> With binutils-2.16 and before, a weak missing symbol was kept during the
> final link, and a missing CRC for an export would lead to that CRC
> being treated as zero implicitly. With binutils-2.17, the crc
> symbol gets dropped, and any module trying to use it will fail to
> load.
> 
> This sets the weak CRC symbol to zero explicitly, making it defined
> in vmlinux, which in turn lets us load the modules referring to
> that CRC.
> 
> The comment above the __CRC_SYMBOL macro suggests that this was
> always the intention, although it also seems that all symbols
> defined in C have a correct CRC these days, and only the exports
> that are now done in assembly need this.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good, works for me, and, unlike faaae2a5, doesn't produce a nasty
user-scaring warning in normal operation.

> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 63554e9..59a3b2f 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -54,6 +54,7 @@ KSYM(__kstrtab_\name):
>  KSYM(__kcrctab_\name):
>  	__put KSYM(__crc_\name)
>  	.weak KSYM(__crc_\name)
> +	.set KSYM(__crc_\name), 0
>  	.previous
>  #endif
>  #endif
