From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq@rere.qmqm.pl>
Subject: Re: [PATCH] percpu: Introduce a read-mostly percpu API
Date: Sat, 23 Oct 2010 04:30:52 +0200
Message-ID: <20101023023052.GA20778@rere.qmqm.pl>
References: <20101023022545.GA18876@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101023022545.GA18876@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Oct 23, 2010 at 04:25:45AM +0200, Micha=B3 Miros=B3aw wrote:
> Commit c957ef2c59e952803766ddc22e89981ab534606f that just went into
> Linus' tree has a bug - only one of hunks was modified (.readmostly
> moved after .page_aligned).

Ah. I just found another commit that fixes it. Sorry for the noise.

Best Regards,
Micha=B3 Miros=B3aw
