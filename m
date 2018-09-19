From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [REVIEW][PATCH 06/20] signal/x86: Move mpx siginfo generation
 into do_bounds
Date: Tue, 18 Sep 2018 22:48:59 -0700
Message-ID: <20180919054859.GB32263@infradead.org>
References: <87y3bzk6yv.fsf@xmission.com>
 <20180918000546.12552-6-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918000546.12552-6-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

> +struct mpx_fault_info
> +{

Normal kernel style would be:

struct mpx_fault_info {
