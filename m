Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:39266 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730967AbeISTa7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 15:30:59 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-6-ebiederm@xmission.com>
        <20180919054859.GB32263@infradead.org>
Date: Wed, 19 Sep 2018 15:52:47 +0200
In-Reply-To: <20180919054859.GB32263@infradead.org> (Christoph Hellwig's
        message of "Tue, 18 Sep 2018 22:48:59 -0700")
Message-ID: <87efdpfvbk.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [REVIEW][PATCH 06/20] signal/x86: Move mpx siginfo generation into do_bounds
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180919135247.k7xfXenGU4uxjMLK0mLAJ_fa0hbfI8hd8yWh4YDLjow@z>

Christoph Hellwig <hch@infradead.org> writes:

>> +struct mpx_fault_info
>> +{
>
> Normal kernel style would be:
>
> struct mpx_fault_info {


Good point.  Fixed.

Eric
