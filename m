From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [REVIEW][PATCH 06/20] signal/x86: Move mpx siginfo generation into do_bounds
Date: Wed, 19 Sep 2018 15:52:47 +0200
Message-ID: <87efdpfvbk.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-6-ebiederm@xmission.com>
        <20180919054859.GB32263@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919054859.GB32263@infradead.org> (Christoph Hellwig's
        message of "Tue, 18 Sep 2018 22:48:59 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> +struct mpx_fault_info
>> +{
>
> Normal kernel style would be:
>
> struct mpx_fault_info {


Good point.  Fixed.

Eric
