From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 26/31] ARC: Build system: Makefiles, Kconfig, Linker
 script
Date: Thu, 15 Nov 2012 17:49:57 +0000
Message-ID: <50A52B45.6030907@imgtec.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-27-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1352281674-2186-27-git-send-email-vgupta@synopsys.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Hi Vineet,

On 07/11/12 09:47, Vineet Gupta wrote:
> +config ARC

I just came across arch/mips/Kconfig which also defines ARC (and ARC32).
It's only used within arch/mips/, however it's probably more likely that
your ARC/CONFIG_ARC will find it's way into the generic bits of the
kernel which could get hit when the other ARC is defined.

Perhaps it's worth getting the other ARC renamed just in case?

Cheers
James
