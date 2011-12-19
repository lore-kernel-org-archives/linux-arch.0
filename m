From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
Date: Mon, 19 Dec 2011 15:01:41 +0200
Message-ID: <4EEF35B5.2090005@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <4EDF7B0D.4060001@redhat.com> <20111208151929.GA6301@mgebm.net> <4EE8BBF4.8070108@redhat.com> <20111214175844.GD4075@mgebm.net> <4EE9C274.3030603@redhat.com> <20111215185346.GA2829@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111215185346.GA2829@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/15/2011 08:53 PM, Eric B Munson wrote:
> I am working on V7 to incorporate the __this_cpu_and suggestion, would you
> consider that for inclusion and we can continue discussing the need for the
> preemption notification work?  

Okay.

> I think that having a guest complain when the
> host is so loaded that the guest watchdog threads can't make any progress is
> desirable behavior, it may be the only notification that an admin gets that a
> particular host is over loaded.

It's the wrong admin, consider a cloud scenario where the host admin and
guest admin are different people.

Notification on host overload (to initiate migration, say) is a good
idea, but it would be a different mechanism.

-- 
error compiling committee.c: too many arguments to function
