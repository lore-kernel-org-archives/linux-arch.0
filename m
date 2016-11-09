From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Tue, 8 Nov 2016 22:08:37 -0800
Message-ID: <CA+55aFyOSHrP0--+dNB0qcoCumTP4KUd6g=2Jt3WUw_W6o+aRg@mail.gmail.com>
References: <20160809172057.GZ4329@intel.com> <20161027172852.GE4617@intel.com>
 <alpine.DEB.2.20.1610272035180.4913@nanos> <20161027192006.GF4617@intel.com>
 <alpine.DEB.2.20.1610272122510.4913@nanos> <20161027203745.GH4617@intel.com>
 <alpine.DEB.2.20.1610272238390.4913@nanos> <20161028155603.GI4617@intel.com>
 <alpine.DEB.2.20.1610282049500.5053@nanos> <20161101204737.GB4617@intel.com> <20161109035418.GA18246@shbuild888>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161109035418.GA18246@shbuild888>
Sender: linux-acpi-owner@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Feng Tang <feng.79.tang@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>, Linux
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 8, 2016 at 7:54 PM, Feng Tang <feng.tang@intel.com> wrote:
> On Wed, Nov 02, 2016 at 04:47:37AM +0800, Ville Syrj=C3=A4l=C3=A4 wrote:
>>
>> I left the thing running for the weekend and it failed 26 out of 16057
>> times with the 25ms timeout. Looks like it takes ~5 minutes to resume
>> when it fails, but eventually it does come back.
>
> Just came back from a travel. Yes, the 5 minutes delay may be due to the
> expiration of the HPET timer, counting from 0 to 0xffffffff for a 13M
> frequencey HPET takes about 300 seconds. After resume, it seems nobody
> arms it so my old patch forces to arm one event.

Ville, what happens if you disable HPET? Can you force the TSC with
"clocksource=3Dtsc" or "tsc=3Dreliable". Does resume work reliably then?

Or is this one of the CPU's where tsc just doesn't work?

              Linus
