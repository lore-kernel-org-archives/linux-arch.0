From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 23/31] arm64: Debugging support
Date: Tue, 21 Aug 2012 09:58:19 +0100
Message-ID: <20120821085819.GD28660@mudshark.cambridge.arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <20120820090754.GB25864@mudshark.cambridge.arm.com>
 <20120820092744.GD25864@mudshark.cambridge.arm.com>
 <201208202010.59985.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201208202010.59985.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "ulrich.weigand@linaro.org" <ulrich.weigand@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 20, 2012 at 09:10:59PM +0100, Arnd Bergmann wrote:
> On Monday 20 August 2012, Will Deacon wrote:
> > On Mon, Aug 20, 2012 at 10:07:54AM +0100, Will Deacon wrote:
> > > On Fri, Aug 17, 2012 at 08:06:07AM +0100, Arnd Bergmann wrote:
> > > > Sorry for the dumb question, but why do you even need PTRACE_GET_THREAD_AREA
> > > > for 64 bit tasks? I thought the thread pointer is a GPR, or is this just
> > > > for compat tasks?
> > > 
> > > The TLS is stored in a co-processor register which is read-only for
> > > userspace.
> > 
> > I should elaborate: the register is RW for AArch64 tasks, RO for aarch32
> > tasks (although that doesn't affect the need for the ptrace request).
> 
> So can't you just /add/ that register to the GPR regset?

We *could*, but it doesn't feel right to me. The TLS register:

	- Can only be manipulated by msr/mrs instructions
	- Is not part of the PCS
	- Is not accessed explicitly by user applications
	- Can not be written via ptrace

so I think it sticks out like a sore thumb if we bundle it up with the GPRs.

Will
