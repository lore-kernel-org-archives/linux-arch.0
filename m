Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751374AbdJ3Okw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Oct 2017 10:40:52 -0400
Date: Mon, 30 Oct 2017 14:40:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3.16.y] percpu: make this_cpu_generic_read() atomic
 w.r.t. interrupts
Message-ID: <20171030144047.7lfjlq4rt4ohnhp3@lakrids.cambridge.arm.com>
References: <20171018134022.25282-1-mark.rutland@arm.com>
 <20171019092434.GA16355@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019092434.GA16355@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org
Message-ID: <20171030144047.d5ZNMYmVA8AMIC1v3lTHygdcif6nFqUtiN14uPgGrI0@z>

On Thu, Oct 19, 2017 at 11:24:34AM +0200, Greg KH wrote:
> You sent 2 patches for 3.16.y, did you mean for one of these to be for
> 3.18.y?

Sorry; I got a bit muddled and thought I hadn't sent the first copy.
Please ignore the duplicate!

I'd ignored 3.18.y as EOL, and neither was intended for 3.18.y.

Sorry for the noise!

Mark.
