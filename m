From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/76] ARC: Checksum/byteorder/swab routines
Date: Fri, 18 Jan 2013 14:21:09 +0000
Message-ID: <201301181421.09458.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-10-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358511930-7424-10-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> TBD: do_csum still needs to be written in asm

Do you actually expect a lot of improvement in do_csum?
I would hope that gcc can actually generate a pretty
good version of it, unless you have some 64-bit add-with-carry
instruction or something else that you could make use of.

> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
