Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:30646 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751951AbWHNJGT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Aug 2006 05:06:19 -0400
Subject: Re: module compiler version check still needed?
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200608130648.36178.ak@suse.de>
References: <200608130648.36178.ak@suse.de>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 11:06:17 +0200
Message-Id: <1155546377.2886.190.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-08-13 at 06:48 +0200, Andi Kleen wrote:
> Does anybody know of any reason why we would still need the compiler version
> check during module loading? AFAIK on i386 it was only needed to handle
> 2.95 (which got dropped) and on x86-64 it was never needed. Is there
> a need on any other architecture for it?

is there any harm in doing this check? Checking this for sure rules out
MANY nasty and really hard to debug corner cases... and there shouldn't
be any valid reason for doing this ever anyway...

