From: Masami Hiramatsu <mhiramat@redhat.com>
Subject: Re: [PATCH -tip -v10 5/7] x86: add pt_regs register and stack access  APIs
Date: Mon, 06 Jul 2009 15:28:02 -0400
Message-ID: <4A525042.5030702@redhat.com>
References: <20090701010838.32547.62843.stgit@localhost.localdomain>	<20090701010911.32547.1313.stgit@localhost.localdomain> <871votop6a.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <systemtap-return-12876-gls-systemtap=m.gmane.org@sourceware.org>
In-Reply-To: <871votop6a.fsf@basil.nowhere.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, lkml <linux-kernel@vger.kernel.org>, systemtap <systemtap@sources.redhat.com>, kvm <kvm@vger.kernel.org>, DLE <dle-develop@lists.sourceforge.net>, Christoph Hellwig <hch@infradead.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Roland McGrath <roland@redhat.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Andi Kleen wrote:
> Masami Hiramatsu <mhiramat@redhat.com> writes:
> 
>> Add following APIs for accessing registers and stack entries from pt_regs.
> 
> You forgot to state who calls these functions/why are they added?
> Who only has strings for registers?

Oh, yes. This patch is needed for kprobes based event tracer on ftrace.
Some other debugging tools might be able to use it.

> I can see the point of having a function for nth argument though,
> that's useful.
> 
>> +static inline unsigned long regs_get_argument_nth(struct pt_regs *regs,
>> +						  unsigned n)
>> +{
>> +	if (n < NR_REGPARMS) {
>> +		switch (n) {
>> +		case 0:
>> +			return regs->ax;
>> +		case 1:
>> +			return regs->dx;
>> +		case 2:
>> +			return regs->cx;
> 
> 
> [....]
> 
> That could be done shorter with a offsetof table.
> 
>> +	if (n < NR_REGPARMS) {
>> +		switch (n) {
>> +		case 0:
>> +			return regs->di;
>> +		case 1:
>> +			return regs->si;
>> +		case 2:
>> +			return regs->dx;
>> +		case 3:
>> +			return regs->cx;
>> +		case 4:
>> +			return regs->r8;
>> +		case 5:
>> +			return regs->r9;
> 
> and that too.

I'm not so sure about your idea.
Would you mean below code?

int offs_table[NR_REGPARMS] = {
	[0] = offsetof(struct pt_regs, di),
	...
};
if (n < NR_REGPARMS)
	return *((unsigned long *)regs + offs_table[n]);


Thank you,

-- 
Masami Hiramatsu

Software Engineer
Hitachi Computer Products (America), Inc.
Software Solutions Division

e-mail: mhiramat@redhat.com
