From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/4 V7] Avoid soft lockup message when KVM is stopped by
 host
Date: Wed, 21 Dec 2011 14:27:26 -0200
Message-ID: <20111221162726.GA26611@amt.cnet>
References: <1323978126-13222-1-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323978126-13222-1-git-send-email-emunson@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>, Avi Kivity <avi@redhat.com>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 15, 2011 at 02:42:02PM -0500, Eric B Munson wrote:
> Changes from V6:
> Use __this_cpu_and when clearing the PVCLOCK_GUEST_STOPPED flag

Avi, 

Do you have any further comments on how this should be done?
