From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: [RFC PATCH 00/10] Use __kernel_[u]long_t for x32 user space compatibility
Date: Thu, 17 May 2012 15:13:26 -0700
Message-ID: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de, "H.J. Lu" <hjl.tools@gmail.com>
List-Id: linux-arch.vger.kernel.org

From: H.J. Lu <hjl.tools@gmail.com>

This patch set changes a number of places where the kernel headers are
exported to user space and currently use explicit "long" or "unsigned
long" to use __kernel_[u]long_t in order to be compatible with the x32
user space ABI.  These location are places where x32 uses the x86-64
ABI.

It is quite possible that some, or even all, of these locations should
really use dedicated types, but in the meantime this gives the correct
results which the current headers do not.
