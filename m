From: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] Add fast little-endian switch system call
Date: Tue, 29 Apr 2008 20:40:47 +0200
Message-ID: <20080429184047.47CB7247B4@gemini.denx.de>
References: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: Your message of "Tue, 29 Apr 2008 12:46:08 +1000."
             <18454.35824.527711.355488-UYQwCShxghk5kJ7NmlRacFaTQe2KTcn/@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

In message <18454.35824.527711.355488-UYQwCShxghk5kJ7NmlRacFaTQe2KTcn/@public.gmane.org> you wrote:
> 
> > Am I missing something here or does this add a branch for every normal
> > syscall?
> 
> It does, but the impact is so small as to be unmeasurable with
> lmbench, even on the null syscall measurement.  The overhead of the
> easily-predicted not-taken branch is completely swamped by the amount
> of time that the sc and rfid instructions take.  I had it under a
> config option at one point but then decided not to bother with that
> when I couldn't measure any difference.

This probably depends a bit on  the  performance  of  the  system  in
question. Did you measure it - for example - on a 50 MHz MPC850 ?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd-ynQEQJNshbs@public.gmane.org
To get something done, a committee should consist  of  no  more  than
three men, two of them absent.
