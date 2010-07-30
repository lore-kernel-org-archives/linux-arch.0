From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] Remove the per cpu tick skew
Date: Fri, 30 Jul 2010 06:57:14 -0700
Message-ID: <20100730065714.3179df46@infradead.org>
References: <20100727210210.58d3118c@infradead.org>
	<20100730072704.GA9960@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100730072704.GA9960@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 30 Jul 2010 17:27:04 +1000
Nick Piggin <npiggin@suse.de> wrote:
> > Nowadays, with the tickless kernel, this contention no longer
> > happens since time keeping and updating are done differently. In
> > addition, this skew is actually hurting power consumption in a
> > measurable way on many-core systems.
> 
> Question, how much of a win is it? What does it do that tickless
> idle does not, can you explain?

tickless idle works great if you're really almost idle

if there's "some work but not fully busy" this still matters


this is not about 'a few milliwatts', but on a server in our labs
(sorry, no hardware details in public) this effect is in the "several
dozen Watts" range.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
