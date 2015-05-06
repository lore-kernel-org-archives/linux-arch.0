From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 2/3] kvm/x86: report guest steal time in host
Date: Wed,  6 May 2015 16:28:44 +0530
Message-ID: <eb56ce41d29c43529bc390d5ea2d5aaab191c918.1429696326.git.naveen.n.rao__7119.03556152738$1430910025$gmane$org@linux.vnet.ibm.com>
References: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: mingo@redhat.com, paulus@samba.org, agraf@suse.de, ego@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

UmVwb3J0IGd1ZXN0IHN0ZWFsIHRpbWUgaW4gaG9zdCB0YXNrIHN0YXRpc3RpY3MuIE9uIHg4Niwg
dGhpcyBpcyBqdXN0CnRoZSBzY2hlZHVsZXIgcnVuX2RlbGF5LgoKU2lnbmVkLW9mZi1ieTogTmF2
ZWVuIE4uIFJhbyA8bmF2ZWVuLm4ucmFvQGxpbnV4LnZuZXQuaWJtLmNvbT4KLS0tCiBhcmNoL3g4
Ni9rdm0veDg2LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYwppbmRleCAwZWU3
MjVmLi43MzdiMGU0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94
ODYva3ZtL3g4Ni5jCkBAIC0yMDk0LDYgKzIwOTQsNyBAQCBzdGF0aWMgdm9pZCByZWNvcmRfc3Rl
YWxfdGltZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAKIAl2Y3B1LT5hcmNoLnN0LnN0ZWFsLnN0
ZWFsICs9IHZjcHUtPmFyY2guc3QuYWNjdW1fc3RlYWw7CiAJdmNwdS0+YXJjaC5zdC5zdGVhbC52
ZXJzaW9uICs9IDI7CisJY3VycmVudC0+Z3N0aW1lICs9IHZjcHUtPmFyY2guc3QuYWNjdW1fc3Rl
YWw7CiAJdmNwdS0+YXJjaC5zdC5hY2N1bV9zdGVhbCA9IDA7CiAKIAlrdm1fd3JpdGVfZ3Vlc3Rf
Y2FjaGVkKHZjcHUtPmt2bSwgJnZjcHUtPmFyY2guc3Quc3RpbWUsCi0tIAoyLjMuNQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1h
aWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96
bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
