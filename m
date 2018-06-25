Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:59370 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeFYVUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2018 17:20:03 -0400
Subject: Re: [PATCH v2] ARC: Improve cmpxchg syscall implementation
References: <20180619142205.20493-1-abrodkin@synopsys.com>
 <bc488b10-cd54-2ef8-46d6-d6c8dc20f799@synopsys.com>
 <6fb4e79964418dec9f1216dabaacfb59a8937134.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <e7a02f0a-314c-ecac-97bd-d6d27168d54a@synopsys.com>
Date: Mon, 25 Jun 2018 14:19:53 -0700
MIME-Version: 1.0
In-Reply-To: <6fb4e79964418dec9f1216dabaacfb59a8937134.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180625211953.ElNqLWQUWq4ECgpMLxJWu0YoC503n76348nQRd8R_0E@z>

On 06/25/2018 02:11 PM, Alexey Brodkin wrote:
>> OK ?
> Sure, care to update the commit log or want me to resend?

I've fixed this up locally and removed a bunch of compile warnings as well.

-Vineet
