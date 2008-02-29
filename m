Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail164.messagelabs.com ([216.82.253.131]:47446 "HELO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752574AbYB2Hp2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Feb 2008 02:45:28 -0500
Date: Fri, 29 Feb 2008 08:45:27 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: let __dec_zone_page_state use __dec_zone_state
Message-ID: <20080229074527.GA32230@digi.com>
References: <20080225132648.GA13791@digi.com> <20080225133846.GA9945@flint.arm.linux.org.uk> <20080225153208.GA15734@digi.com> <20080225154503.GA16223@digi.com> <Pine.LNX.4.64.0802271108500.32462@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0802271108500.32462@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

Hello Christoph,

Christoph Lameter wrote:
> On Mon, 25 Feb 2008, Uwe Kleine-König wrote:
> 
> > This removes code duplication and makes __dec_zone_page_state look like
> > __inc_zone_page_state.
> 
> Acked-by: Christoph Lameter <clameter@sgi.com>
Unless Linus or Andrew take that patch I think the best path for that
patch into mainline is going over your tree.

Best regards
Uwe

-- 
Uwe Kleine-König, Software Engineer
Digi International GmbH Branch Breisach, Küferstrasse 8, 79206 Breisach, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 13962
