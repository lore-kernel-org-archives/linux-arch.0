Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Feb 2005 15:15:11 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050205151511.3d1d6335.davem@davemloft.net>
In-Reply-To: <20050204231816.76b989a6.akpm@osdl.org>
References: <200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<20050205065452.GA32565@wotan.suse.de>
	<20050204231816.76b989a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, torvalds@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Fri, 4 Feb 2005 23:18:16 -0800
Andrew Morton <akpm@osdl.org> wrote:

> TASK_SIZE is a property of the mm_struct, is it not?

I agree.

This is being restated several times, and hope that there
is some kind of consensus on this issue at this point.
