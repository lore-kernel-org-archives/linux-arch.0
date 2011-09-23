From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Device trees and systems-on-a-chip
Date: Fri, 23 Sep 2011 22:56:18 +0200
Message-ID: <1420112.d5BXaqWxOG@wuerfel>
References: <20110923171300.GA15815@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110923171300.GA15815@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 23 September 2011 12:13:00 Linas Vepstas wrote:
> Here:  http://lwn.net/Articles/457635/  you say:  "If the device tree
> vision comes true, a single board will actually be able to use the
> same device tree binary on either one, independent of which CPU
> actually runs the kernel."
> 
> In my case, the hexagon and the arm cores will perceive the same
> devices at different addresses; there are also devices attached to one
> core that aren't attached to the other.  So either we have two DT's,
> one for each core, or we have one DT with subsections for each core.    
> 
> I haven't yet looked to see how the DT's are being designed, but I have
> this sneaking suspicion that the second alternative is not being
> pursued ...

Hi Linas,

You can have .dtsi include files that describe the common parts and
just put the child buses at different addresses or leave them out
from a main .dts source file.
I think it should all work out. If not, there is still the option
of adding features to dtc to allow what you need.

	Arnd
