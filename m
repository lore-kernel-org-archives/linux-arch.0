Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:37752 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbCKOgB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 10:36:01 -0400
Received: by wggx13 with SMTP id x13so9717869wgg.4
        for <linux-arch@vger.kernel.org>; Wed, 11 Mar 2015 07:36:00 -0700 (PDT)
Message-ID: <550052CD.5040303@plexistor.com>
Date: Wed, 11 Mar 2015 16:35:57 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] mm: kill kmemcheck
References: <1426074547-21888-1-git-send-email-sasha.levin@oracle.com>	<20150311081909.552e2052@grimm.local.home>	<55003666.3020100@oracle.com> <20150311084034.04ce6801@grimm.local.home> <55004595.7020304@oracle.com>
In-Reply-To: <55004595.7020304@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sasha Levin <sasha.levin@oracle.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-ID: <20150311143557.xxyD6pGRwtEH_zCP6vtwTwoxmONsVqY6xUty_GIJl1k@z>

On 03/11/2015 03:39 PM, Sasha Levin wrote:
> On 03/11/2015 08:40 AM, Steven Rostedt wrote:
>> On Wed, 11 Mar 2015 08:34:46 -0400
>> Sasha Levin <sasha.levin@oracle.com> wrote:
>>
>>>> Fair enough. We knew there are existing kmemcheck users, but KASan should be
>>>> superior both in performance and the scope of bugs it finds. It also shouldn't
>>>> impose new limitations beyond requiring gcc 4.9.2+.
>>>>
>> Ouch! OK, then I can't use it. I'm currently compiling with gcc 4.6.3.
>>
>> It will be a while before I upgrade my build farm to something newer.
> 
> Are you actually compiling new kernels with 4.6.3, or are you using older
> kernels as well?
> 
> There's no real hurry to kill kmemcheck right now, but we do want to stop
> supporting that in favour of KASan.
> 

Just my $0.017 for me I wish there was the single config MEM_CHECK and
the new or old would be selected automatically depending on enabling
factors, for example gcc version, if arch dependent and so on.

Thanks
Boaz

