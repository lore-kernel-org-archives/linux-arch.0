From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 21/31] arm64: 32-bit (compat) applications support
Date: Sun, 26 Aug 2012 04:49:32 +0000
Message-ID: <201208260449.32807.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151434.05145.arnd@arndb.de> <20120824104338.GI7585@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120824104338.GI7585@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Friday 24 August 2012, Catalin Marinas wrote:
> > What good is the run-time BUG() here? Nothing should be calling these
> > when CONFIG_COMPAT is disabled, so I think you should just remove
> > the #ifdef around the declarations, and the entire #else case.
> 
> They are called from handle_signal(), so that's to avoid #ifdef inside
> functions. I can drop the BUG() (but keep the empty function) and
> change the checks to is_compat_task() so that the compiler optimises the
> condition out when !COMPAT.
> 

Sounds good. Note that you can turn a lot of #ifdef into
if(IS_ENABLED(CONFIG_FOO)) as well, even if there is no other runtime
check for them.

	Arnd
