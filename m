From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 11/26] signal/x86: Remove task parameter from
 send_sigtrap
Date: Tue, 28 May 2019 11:18:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.1905281118290.1859@nanos.tec.linutronix.de>
References: <20190523003916.20726-1-ebiederm@xmission.com> <20190523003916.20726-12-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523003916.20726-12-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 22 May 2019, Eric W. Biederman wrote:

> The send_sigtrap function is always called with task == current.  Make
> that explicit by removing the task parameter.
> 
> This also makes it clear that the x86 send_sigtrap passes current
> into force_sig_fault.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
