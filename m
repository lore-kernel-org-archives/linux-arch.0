Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:64975 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759878Ab3HOSm0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Aug 2013 14:42:26 -0400
MIME-Version: 1.0
In-Reply-To: <87ioz67qq0.fsf@nemi.mork.no>
References: <52050382.9060802@gmail.com>
	<520BB225.8030807@gmail.com>
	<20130814174039.GA24033@dhcp22.suse.cz>
	<CA+55aFwAz7GdcB6nC0Th42y8eAM591sKO1=mYh5SWgyuDdHzcA@mail.gmail.com>
	<20130814182756.GD24033@dhcp22.suse.cz>
	<CA+55aFxB6Wyj3G3Ju8E7bjH-706vi3vysuATUZ13h1tdYbCbnQ@mail.gmail.com>
	<520C9E78.2020401@gmail.com>
	<CA+55aFy2D2hTc_ina1DvungsCL4WU2OTM=bnVb8sDyDcGVCBEQ@mail.gmail.com>
	<CA+55aFxuUrcod=X2t2yqR_zJ4s1uaCsGB-p1oLTQrG+y+Z2PbA@mail.gmail.com>
	<87ioz67qq0.fsf@nemi.mork.no>
Date: Thu, 15 Aug 2013 11:42:25 -0700
Message-ID: <CA+55aFxpguNh5Fi7q4WwHMFdBF2YL+gj_o7d67X8hV_XF9Zz4A@mail.gmail.com>
Subject: Re: [Bug] Reproducible data corruption on i5-3340M: Please revert 53a59fc67!
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: Ben Tebulin <tebulin@googlemail.com>, Michal Hocko <mhocko@suse.cz>, Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, Balbir Singh <bsingharora@gmail.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-mm <linux-mm@kvack.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20130815184225.qd0v0bV2Xp0NjuV65Qw1CJNzBQ2YUzWZv6s6zRLQGiw@z>

On Thu, Aug 15, 2013 at 11:29 AM, Bjørn Mork <bjorn@mork.no> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> Comments? Especially s390, ARM, ia64, sh and um that I edited blindly...
>
> I can see that :-)  You have a couple of "unsigned logn"s here.

Just checking that you guys are awake.

Good job. You passed.

                 Linus
