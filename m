Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Feb 2005 10:56:38 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] add and use COMPAT_SIGEV_PAD_SIZE
Message-Id: <20050222105638.57d32884.davem@davemloft.net>
In-Reply-To: <20050222181530.5afa4e72.sfr@canb.auug.org.au>
References: <20050222181530.5afa4e72.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 22 Feb 2005 18:15:30 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> All the 32 bit architectures (effectively) define SIGEV_PAD_SIZE to be
> ((SIGEV_MAX_SIZE/sizeof(int)) - 3).  So define COMPAT_SIGEV_PAD_SIZE to be
> this and replace SIGEV_PAD_SIZE32 where it is used.  It also needs to be
> used in the definition of struct compat_sigevent as most of the
> architectures would have had it 4 bytes too small in teh kernel (since we
> were using SIGEV_PAD_SIZE).
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> I will submit this to Andrew is it is deemed OK.  I intend to build on
> this patch.

I'm fine with this patch too.
