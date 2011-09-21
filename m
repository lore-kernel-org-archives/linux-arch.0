From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Wed, 21 Sep 2011 12:50:09 -0500
Message-ID: <20110921175009.GA3703@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org>
 <201109101229.58445.pedro@codesourcery.com>
 <20110919152505.GB6830@codeaurora.org>
 <201109211715.20795.pedro@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201109211715.20795.pedro@codesourcery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pedro Alves <pedro@codesourcery.com>
Cc: Jonas Bonn <jonas.bonn@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 21, 2011 at 05:15:20PM +0100, Pedro Alves wrote:
> > On Sat, Sep 10, 2011 at 12:29:57PM +0100, Pedro Alves wrote:
> > > Yes, the x86/x86-64 ports or gdb and gdbserver are already
> > > using GET/SETREGSET even.

Thanks; after a bit of initial confusion, I've gotten gdb to
work with this, so I'm happy. 

> I wish there was an equivalent of PTRACE_GETREGSET for siginfo...

How? Why?

-- Linas

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
