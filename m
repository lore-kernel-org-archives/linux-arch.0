Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:42428 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbfFCSpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 14:45:05 -0400
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <895ec12746c246579aed5dd98ace6e38@AcuMS.aculab.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <b6dbe51f-88a8-0b18-e0e7-147d8022ad54@synopsys.com>
Date: Mon, 3 Jun 2019 11:44:52 -0700
MIME-Version: 1.0
In-Reply-To: <895ec12746c246579aed5dd98ace6e38@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <20190603184452.poAsFnjBWHUtJr8Wishe6QdKRiDRZevg5tJDMEnmxuY@z>

On 5/31/19 2:41 AM, David Laight wrote:
>> While it seems reasonable form hardware pov to not implement such atomicity by
>> default it seems there's an additional burden on application writers. They could
>> be happily using a lockless algorithm with just a shared flag between 2 threads
>> w/o need for any explicit synchronization. But upgrade to a new compiler which
>> aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
>> causing the code to suddenly stop working. Is the onus on them to declare such
>> memory as c11 atomic or some such.
> A 'new' compiler can't suddenly change the alignment rules for structure elements.
> The alignment rules will be part of the ABI.
> 
> More likely is that the structure itself is unexpectedly allocated on
> an 8n+4 boundary due to code changes elsewhere.

Indeed thats what I meant that the layout changed as is typical of a new compiler.
