Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:64554 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890AbaDVOzj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 10:55:39 -0400
Received: by mail-ve0-f176.google.com with SMTP id db11so9428206veb.7
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2014 07:55:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+8MBbLvWuSfP+7CFwAmSwNX7Uekob5p52BuwfkW=oz9=202HQ@mail.gmail.com>
References: <1398032742.19682.11.camel@pasglop>
	<CA+55aFz1sK+PF96LYYZY7OB7PBpxZu-uNLWLvPiRz-tJsBqX3w@mail.gmail.com>
	<1398054064.19682.32.camel@pasglop>
	<1398057630.19682.38.camel@pasglop>
	<CA+55aFwWHBtihC3w9E4+j4pz+6w7iTnYhTf4N3ie15BM9thxLQ@mail.gmail.com>
	<53558507.9050703@zytor.com>
	<CA+55aFxGm6J6N=4L7exLUFMr1_siNGHpK=wApd9GPCH1=63PPA@mail.gmail.com>
	<53559F48.8040808@intel.com>
	<CA+55aFwDtjA4Vp0yt0K5x6b6sAMtcn=61SEnOOs_En+3UXNpuA@mail.gmail.com>
	<CA+55aFzFxBDJ2rWo9DggdNsq-qBCr11OVXnm64jx04KMSVCBAw@mail.gmail.com>
	<CA+8MBbLvWuSfP+7CFwAmSwNX7Uekob5p52BuwfkW=oz9=202HQ@mail.gmail.com>
Date: Tue, 22 Apr 2014 07:55:38 -0700
Message-ID: <CA+55aFye7U7LAewDv=Lpb8V+g0FWiVtuAZdy-b6cAoRQXZZZcw@mail.gmail.com>
Subject: Re: Dirty/Access bits vs. page content
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20140422145538.KzuhN_o5AktbxdrS92kmYkqgm-NoLR2E_JglVEZXyOM@z>

On Mon, Apr 21, 2014 at 10:15 PM, Tony Luck <tony.luck@gmail.com> wrote:
>
> It builds and boots on ia64 with no new warnings.  I haven't done
> anything more stressful than booting though - so unsure whether
> there are any corners cases that might show up under load.

Thanks. It shouldn't actually change any behavior on ia64 (you'd have
to do any dirty bit batching yourself), I was mainly worried about
compile warnings due to not having the set_page_dirty() declaration
due to some odd header file issues.

               Linus
