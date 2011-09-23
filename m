From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: Device trees and systems-on-a-chip
Date: Fri, 23 Sep 2011 12:13:00 -0500
Message-ID: <20110923171300.GA15815@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Arnd,

Here:  http://lwn.net/Articles/457635/  you say:  "If the device tree
vision comes true, a single board will actually be able to use the
same device tree binary on either one, independent of which CPU
actually runs the kernel."

In my case, the hexagon and the arm cores will perceive the same
devices at different addresses; there are also devices attached to one
core that aren't attached to the other.  So either we have two DT's,
one for each core, or we have one DT with subsections for each core.    

I haven't yet looked to see how the DT's are being designed, but I have
this sneaking suspicion that the second alternative is not being
pursued ...

--linas

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
