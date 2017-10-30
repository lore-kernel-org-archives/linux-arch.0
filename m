From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3.16.y] percpu: make this_cpu_generic_read() atomic
 w.r.t. interrupts
Date: Mon, 30 Oct 2017 14:40:47 +0000
Message-ID: <20171030144047.7lfjlq4rt4ohnhp3@lakrids.cambridge.arm.com>
References: <20171018134022.25282-1-mark.rutland@arm.com>
 <20171019092434.GA16355@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171019092434.GA16355@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 19, 2017 at 11:24:34AM +0200, Greg KH wrote:
> You sent 2 patches for 3.16.y, did you mean for one of these to be for
> 3.18.y?

Sorry; I got a bit muddled and thought I hadn't sent the first copy.
Please ignore the duplicate!

I'd ignored 3.18.y as EOL, and neither was intended for 3.18.y.

Sorry for the noise!

Mark.
