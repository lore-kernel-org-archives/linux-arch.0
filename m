From: Christoph Lameter <clameter-sJ/iWh9BUns@public.gmane.org>
Subject: Re: What if a TLB flush needed to sleep?
Date: Thu, 27 Mar 2008 11:44:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0803271143540.7531@schroedinger.engr.sgi.com>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
  <Pine.LNX.4.64.0803261222090.31000@schroedinger.engr.sgi.com>
 <alpine.LFD.1.00.0803262121440.3781@apollo.tec.linutronix.de>
 <Pine.LNX.4.64.0803261817110.1115@schroedinger.engr.sgi.com>
 <1206624052.8514.570.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1206624052.8514.570.camel@twins>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 27 Mar 2008, Peter Zijlstra wrote:

> confusion between semaphores and rwsems

rwsem is not a semaphore despite its name? What do you want to call it 
then?
