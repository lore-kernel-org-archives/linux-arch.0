From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 14/20] pxa2xx-flash: switch from ioremap_cache to memremap
Date: Mon, 12 Oct 2015 13:36:13 -0700
Message-ID: <CAPcyv4jBaM4jASAgY6O1if+LbYW7TdFBkMt8ZDATL7wrE7LUEQ@mail.gmail.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
	<20151009221651.32203.63446.stgit@dwillia2-desk3.jf.intel.com>
	<20151012175803.GL107187@google.com>
	<20151012203101.GM107187@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32794 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbJLUgP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2015 16:36:15 -0400
Received: by wicge5 with SMTP id ge5so31707835wic.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2015 13:36:14 -0700 (PDT)
In-Reply-To: <20151012203101.GM107187@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brian Norris <computersforpeace@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mtd@lists.infradead.org

On Mon, Oct 12, 2015 at 1:31 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Mon, Oct 12, 2015 at 10:58:03AM -0700, Brian Norris wrote:
>> You missed linux-mtd again. Please use scripts/get_maintainer.pl next
>> time to at least get the relevant mailing list(s). (The individual CC's
>> are not always necessary, but the subsystem lists definitely are.)
>
> Anyway, pushed to l2-mtd.git.
>

Thanks Brian, I'll watch out for that next time.
