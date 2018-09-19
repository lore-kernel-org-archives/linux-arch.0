From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [REVIEW][PATCH 12/20] signal/x86: Remove pkey parameter from
 bad_area_nosemaphore
Date: Wed, 19 Sep 2018 09:33:42 -0700
Message-ID: <ed6d5892-4a05-40b7-0ebd-58efc5cc7d3e@linux.intel.com>
References: <87y3bzk6yv.fsf@xmission.com>
 <20180918000546.12552-12-ebiederm@xmission.com>
 <alpine.DEB.2.21.1809182242380.1468@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1809182242380.1468@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/18/2018 01:44 PM, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>> The function bad_area_nosemaphore always sets si_code to SEGV_MAPERR
>> and as such can never return a pkey parameter.  Therefore remove the
>> unusable pkey parameter from bad_area_nosemaphore.

The result of this looks nice to me.  It's especially nice to see the
scope where we have to pass around the pkey get reduced.

I also ran the pkey selftests against the current version of your
siginfo-testing branch.  Everything passes fine on my pkey-enabled system.
