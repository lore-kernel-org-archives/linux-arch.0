From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] [2/9] Add a kernel_address() that works for data too
Date: Tue, 5 Jan 2010 20:15:03 +0100
Message-ID: <20100105191503.GH1778@basil.fritz.box>
References: <20100105315.789846878@firstfloor.org> <20100105021527.1AB19B17C2@basil.firstfloor.org> <20100105085853.GA28126@merkur.ravnborg.org> <20100105190455.GE30868@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755330Ab0AETPQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100105190455.GE30868@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <andi@firstfloor.org>, linux-arch@vger.kernel.org, ebiederm@xmission.com, paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org, linux-kern
List-Id: linux-arch.vger.kernel.org

> I'd suggest the only way to identify the data segment in a generic way
> is to have everyone define _sdata, or more preferably _data (to be
> consistent with _text), to be the start of the data segment.

I agree. I'll take a look at that.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
