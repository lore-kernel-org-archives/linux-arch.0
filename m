Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Mar 2005 20:12:24 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] consolidate asm/ipc.h
Message-Id: <20050322201224.77dcb84e.davem@davemloft.net>
In-Reply-To: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 23 Mar 2005 15:01:23 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> All the asm*/ipc.h files are basically the same (for things that are used)
> so I have consolidated them all into asm-generic/ipc.h
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Looks good to me.
