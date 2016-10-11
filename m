From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Is conditional calling of restore_altstack() correct for ARC
Date: Tue, 11 Oct 2016 11:04:41 -0700
Message-ID: <c8ead7fd-9444-da25-74e9-f755da6296d5@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Al,

I spotted a possible anomaly with ARC sigaltstack() handling and was wondering if
you could confirm if it was wrong (I don't have a test case to prove one way or
the other).

We have a micro-optimization which elides calling restore_altstack() in sigreturn
path, based on a "magic" value, set at the time of sigaction (SA_SIGINFO). So
essentially we only restore ss_{sp,size,flags} if SA_SIGINFO was set.

Do you think this needs to be done unconditionally like other ports do ?

Thx,
-Vineet
