From: Roland McGrath <roland@redhat.com>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Fri, 12 Sep 2008 15:39:26 -0700 (PDT)
Message-ID: <20080912223926.5EF0715420D@magilla.localdomain>
References: <20080912025733.E55F415420D@magilla.localdomain>
	<20080912131351.GA31545@flint.arm.linux.org.uk>
	<20080912223156.51D4815420D@magilla.localdomain>
	<20080912.153703.21849753.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <utrace-devel-bounces@redhat.com>
In-Reply-To: David Miller's message of  Friday,
	12 September 2008 15:37:03 -0700
	<20080912.153703.21849753.davem@davemloft.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/utrace-devel>,
	<mailto:utrace-devel-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/utrace-devel>
List-Post: <mailto:utrace-devel@redhat.com>
List-Help: <mailto:utrace-devel-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/utrace-devel>,
	<mailto:utrace-devel-request@redhat.com?subject=subscribe>
Sender: utrace-devel-bounces@redhat.com
Errors-To: utrace-devel-bounces@redhat.com
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, utrace-devel@redhat.com, rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> It was allocating too much memory, which is harmless.

Didn't it also write NT_PRFPREG notes of the wrong size?


Thanks,
Roland
