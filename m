From: Richard Weinberger <richard@nod.at>
Subject: Question on ARC's thread_info
Date: Sun, 29 Mar 2015 00:18:28 +0100
Message-ID: <551736C4.6080203@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "vgupta@synopsys.com" <vgupta@synopsys.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Vineet,

I'm working on a patch series which touches sturct thread_info.
ARC's thread_info has the following comment:
 * - if the contents of this structure are changed, the assembly constants
 *   must also be changed

Is this still true? Unless I'm reading the code wrong that case should be
handled automatically by the asm-offsets mechanism.
So no manual fixup of magic constants should be needed.

Thanks,
//richard
