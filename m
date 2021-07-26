Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CE0C4320A
	for <linux-arch@archiver.kernel.org>; Mon, 26 Jul 2021 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B9260F91
	for <linux-arch@archiver.kernel.org>; Mon, 26 Jul 2021 20:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhGZTsp (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:48:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37256 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhGZTsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 15:48:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m87Ds-001veA-FK; Mon, 26 Jul 2021 14:29:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43746 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m87Dr-003xRj-Fd; Mon, 26 Jul 2021 14:29:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Brad Boyer <flar@allandria.com>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
        <877dhio13t.fsf@disp2133>
        <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
        <87tukkk6h3.fsf@disp2133>
        <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
        <87eebn7w7y.fsf@igel.home>
        <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
        <20210725101253.GA6096@allandria.com>
        <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com>
        <87a6m8kgtx.fsf_-_@disp2133> <875yww7s01.fsf@igel.home>
Date:   Mon, 26 Jul 2021 15:29:04 -0500
In-Reply-To: <875yww7s01.fsf@igel.home> (Andreas Schwab's message of "Mon, 26
        Jul 2021 22:13:50 +0200")
Message-ID: <87k0lcizu7.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m87Dr-003xRj-Fd;;;mid=<87k0lcizu7.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+z32KOejNI9Ouby2CSqkDgwF558HbGxx0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 26 2021, Eric W. Biederman wrote:
>
>> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
>> index a8f41615d94a..ec767523c012 100644
>> --- a/arch/m68k/fpsp040/skeleton.S
>> +++ b/arch/m68k/fpsp040/skeleton.S
>> @@ -502,7 +502,8 @@ in_ea:
>>  	.section .fixup,#alloc,#execinstr
>>  	.even
>>  1:
>> -	jbra	fpsp040_die
>> +	bsrl	fpsp040_die
>> +	jmp	.Lnotkern
>
> That should be jbra instead of jmp.

I will update my patch.  Mind if I ask what the difference is?

I could not find a reference mentioning jbra.  Do I need to look in the
gas source or do you know if there is a better source?

Eric

