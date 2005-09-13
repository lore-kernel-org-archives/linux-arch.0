Return-Path: <linux-arch-owner@vger.kernel.org>
From: Andi Kleen <ak@suse.de>
Subject: Re: Kill HAVE_DEC_LOCK
Date: Tue, 13 Sep 2005 08:15:50 +0200
References: <20050912.160503.93067051.davem@davemloft.net>
In-Reply-To: <20050912.160503.93067051.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130815.51050.ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 13 September 2005 01:05, David S. Miller wrote:

>
> 2) i386/x86_64 - similar to ppc64 C code which is now used except
>    that cmpxchg() macro was open coded.  The new generic version
>    should end up producing similar if not identical code.

Looks good.  Unfortunately XADD cannot be used for that.

-Andi
