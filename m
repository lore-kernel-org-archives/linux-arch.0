From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 06/28] nios2: Memory management
Date: Tue, 22 Apr 2014 11:24:43 -0300
Message-ID: <20140422142443.GB15745@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-5-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397824031-4892-5-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Hi Ley Foon,

On Apr 18, Ley Foon Tan wrote:
> +/*
> + * PAGE_SHIFT determines the page size
> + */
> +#define PAGE_SHIFT	12
> +#define PAGE_SIZE	4096
> +#define PAGE_MASK	(~(PAGE_SIZE - 1))
> +

How about something like this:

/* PAGE_SHIFT determines the page size */
#define PAGE_SHIFT              12
#define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)
#define PAGE_MASK               (~((1 << PAGE_SHIFT) - 1))

Otherwise, the PAGE_SIZE macro above produces some warnings, IIRC.

--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
