Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60936
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752844AbXGYG3P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 02:29:15 -0400
Date: Tue, 24 Jul 2007 23:29:14 -0700 (PDT)
Message-Id: <20070724.232914.56812376.davem@davemloft.net>
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
From: David Miller <davem@davemloft.net>
In-Reply-To: <46A6ECB7.7090208@goop.org>
References: <21803.1185331847@ocs10w.ocs.com.au>
	<46A6DB04.3000003@zytor.com>
	<46A6ECB7.7090208@goop.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: jeremy@goop.org
Cc: hpa@zytor.com, kaos@ocs.com.au, xyzzy@speakeasy.org, viro@ftp.linux.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Tue, 24 Jul 2007 23:24:55 -0700

> H. Peter Anvin wrote:
> > How far back was __builtin_trap() supported?
> 
> I think its relatively recent, but it might be within our supported
> compiler window.

I'm pretty sure it is.
