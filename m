Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Feb 2005 10:55:29 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-Id: <20050222105529.1eea1a52.davem@davemloft.net>
In-Reply-To: <20050223004228.3ae0207e.sfr@canb.auug.org.au>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
	<20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk>
	<20050218162229.63d69935.sfr@canb.auug.org.au>
	<20050223003651.115d05ef.sfr@canb.auug.org.au>
	<20050223004228.3ae0207e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 23 Feb 2005 00:42:28 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I will submit this to Andrew if there are no further comments.

I'm ok with this.

In the long term, we should stop using signed argument types for
compat_sys_*() functions.  Most of the time, it can be ok because
it's some selector value, but often it results in signedness bugs
and even security holes especially when dealing with length values.
