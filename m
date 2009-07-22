From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH] percpu: kill legacy percpu allocator
Date: Wed, 22 Jul 2009 14:00:19 +0930
Message-ID: <200907221400.21969.rusty@rustcorp.com.au>
References: <1248171979-29166-1-git-send-email-tj@kernel.org> <4A65B314.1000907@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751438AbZGVEa2@vger.kernel.org>
In-Reply-To: <4A65B314.1000907@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, benh@kernel.crashing.org, davem@davemloft.net, dhowells@redhat.com, npiggin@suse.de, JBeulich@novell.com, cl@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, x86@kernel.org, andi@firstfloor.org
List-Id: linux-arch.vger.kernel.org

On Tue, 21 Jul 2009 09:52:44 pm Tejun Heo wrote:
>  include/linux/percpu.h |   24 ------
>  kernel/module.c        |  150 -----------------------------------------

FWIW, I'm looking fwd to this.  module.c doesn't shrink very often :)

Thanks,
Rusty.
