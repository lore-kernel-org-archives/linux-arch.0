From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Wed, 10 Dec 2008 11:28:19 +0100
Message-ID: <20081210102819.GF23556@one.firstfloor.org>
References: <20081205.002701.172921476.davem@davemloft.net> <20081205084233.GE2030@elte.hu> <87ej0mx0c0.fsf@basil.nowhere.org> <20081205.120814.51226316.davem@davemloft.net> <20081210034824.GA27217@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:60609 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbYLJKQn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Dec 2008 05:16:43 -0500
Content-Disposition: inline
In-Reply-To: <20081210034824.GA27217@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>, David Miller <davem@davemloft.net>, andi@firstfloor.org, mingo@elte.hu, a.p.zijlstra@chello.nl, paulus@samba.org, tglx@linutronix.de, linux-kernel@vg

> Oprofile has been a pretty bad fit for them, and while I'm slightly more

You could always use a extension of timer mode that reads them
periodically? 

-Andi
-- 
ak@linux.intel.com
